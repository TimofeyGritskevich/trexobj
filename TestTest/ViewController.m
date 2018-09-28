//
//  ViewController.m
//  TestTest
//
//  Created by Tima on 11.09.2018.
//  Copyright © 2018 Timofey Gritkevich. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "Film.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSArray *allFilmArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateFilmArray];
}

- (void) updateFilmArray {
    [self loadData:^(NSMutableArray *films) {
        self.allFilmArray = films;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            
        });
    }];
}

#pragma mark - CollectionView

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allFilmArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FilmCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilmCell" forIndexPath:indexPath];
    [cell loadWithContact:[self.allFilmArray objectAtIndex:indexPath.item]];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView reloadData];
    
    FilmViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"FilmViewController"];
    controller.film = [self.allFilmArray objectAtIndex:indexPath.item];
    [self.navigationController pushViewController:controller animated:true];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    NSInteger height = 0;
    Film *film = [self.allFilmArray objectAtIndex:indexPath.item];

    height = [self getHeightForTextView:film.nameRus fontSize:20] + [self getHeightForTextView:film.nameEng fontSize:15] + [self getHeightForTextView:film.content fontSize:12] + [self getHeightForTextView:film.premiere fontSize:15];

    if (height+20 < 133) {
        height = 133;
    }
    
    return CGSizeMake(self.view.frame.size.width, height+20);
}

- (NSInteger)getHeightForTextView:(NSString *) string fontSize:(double) fontSize {
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:fontSize]};
    CGRect rect = [string boundingRectWithSize:CGSizeMake(self.view.frame.size.width-144, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:attributes
                                             context:nil];
    return rect.size.height;
}

#pragma mark - RotateDevice

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView reloadData];
}

#pragma mark - filmArray

- (void)loadData:(void ( ^ )(NSMutableArray*) )premiereArray {
    
    NSString *urlString = @"http://www.mocky.io/v2/57cffac8260000181e650041";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *filmJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err){
            NSLog(@"FAILD %@", err);
            return;
        }
        
        NSMutableArray *filmArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *filmDict in filmJSON[@"list"]) {
            NSString *nameRus = filmDict[@"name"];
            NSString *nameEng = filmDict[@"name_eng"];
            NSString *content = filmDict[@"description"];
            NSString *premiere = filmDict[@"premiere"];
            NSString *imageUrl = filmDict[@"image"];
            
            Film *newFilm = [[Film alloc] initWithName:nameRus
                                               nameEng:nameEng
                                               content:content
                                              premiere:premiere
                                              imageUrl:imageUrl];
            [filmArray addObject:newFilm];
        }
        
        premiereArray(filmArray);
        
    }] resume];
}

@end
