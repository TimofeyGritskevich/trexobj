//
//  Film.m
//  TestTest
//
//  Created by Tima on 11.09.2018.
//  Copyright © 2018 Timofey Gritkevich. All rights reserved.
//

#import "Film.h"

@implementation Film

- (instancetype)initWithName:(NSString *)nameRus
                     nameEng:(NSString *)nameEng
                     content:(NSString *)content
                    premiere:(NSString *)premiere
                    imageUrl:(NSString *)imageUrl {
    
    if (self = [super init]) {
        self.nameRus = nameRus;
        self.nameEng = nameEng;
        self.content = content;
        self.premiere = premiere;
        self.imageUrl = imageUrl;
    }
    
    return self;
}

@end
