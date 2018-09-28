//
//  FilmCell.h
//  TestTest
//
//  Created by Tima on 12.09.2018.
//  Copyright © 2018 Timofey Gritkevich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Film.h"

@interface FilmCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *filmCover;
@property (weak, nonatomic) IBOutlet UITextView *nameRusTextView;
@property (weak, nonatomic) IBOutlet UITextView *nameEngTextView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextView *premiereTextView;

- (void) loadWithContact:(Film *)film;


@end
