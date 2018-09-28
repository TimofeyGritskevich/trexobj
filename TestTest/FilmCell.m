//
//  FilmCell.m
//  TestTest
//
//  Created by Tima on 12.09.2018.
//  Copyright © 2018 Timofey Gritkevich. All rights reserved.
//

#import "FilmCell.h"

@implementation FilmCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void) loadWithContact:(Film *)film {
    
    [self.nameRusTextView setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.nameEngTextView setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.contentTextView setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.premiereTextView setTextContainerInset:UIEdgeInsetsMake(0, 0, 0, 0)];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                        NSURL *imageURL = [NSURL URLWithString:film.imageUrl];
                        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            
                            self.filmCover.image = [UIImage imageWithData:imageData];
                           });
                   });

    self.nameRusTextView.text = film.nameRus;
    self.nameEngTextView.text = film.nameEng;
    self.contentTextView.text = film.content;
    self.premiereTextView.text = [NSString stringWithFormat:@"премьера: %@", film.premiere];
}

@end
