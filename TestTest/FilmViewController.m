//
//  FilmViewController.m
//  TestTest
//
//  Created by Tima on 12.09.2018.
//  Copyright © 2018 Timofey Gritkevich. All rights reserved.
//

#import "FilmViewController.h"

@interface FilmViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *filmCover;
@property (weak, nonatomic) IBOutlet UITextView *filmNameTextView;
@property (weak, nonatomic) IBOutlet UITextView *filmPremiereTextView;
@property (weak, nonatomic) IBOutlet UITextView *filmContentTextView;

@end

@implementation FilmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
}

- (void) setViews {

    [self.filmNameTextView setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.filmPremiereTextView setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.filmContentTextView setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       NSURL *imageURL = [NSURL URLWithString:self.film.imageUrl];
                       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                       
                       dispatch_sync(dispatch_get_main_queue(), ^{
                           
                           self.filmCover.image = [UIImage imageWithData:imageData];
                       });
                   });
  
    self.filmNameTextView.text = [NSString stringWithFormat:@"%@(%@)", self.film.nameRus, self.film.nameEng];
    self.filmPremiereTextView.text = [NSString stringWithFormat:@"премьера: %@", self.film.premiere];
    self.filmContentTextView.text = self.film.content;
};

@end
