//
//  Film.h
//  TestTest
//
//  Created by Tima on 11.09.2018.
//  Copyright © 2018 Timofey Gritkevich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Film: NSObject

@property (nonatomic) NSString *nameRus;
@property (nonatomic) NSString *nameEng;
@property (nonatomic) NSString *content;
@property (nonatomic) NSString *premiere;
@property (nonatomic) NSString *imageUrl;

- (instancetype)initWithName:(NSString *)nameRus
                     nameEng:(NSString *)nameEng
                     content:(NSString *)content
                    premiere:(NSString *)premiere
                    imageUrl:(NSString *)imageUrl;

@end
