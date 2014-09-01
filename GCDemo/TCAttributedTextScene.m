//
//  TCAttributedTextScene.m
//  GCDemo
//
//  Created by Joachim Bengtsson on 2014-09-01.
//  Copyright (c) 2014 ThirdCog. All rights reserved.
//

#import "TCAttributedTextScene.h"
#import "GameControllerDemo-Swift.h"

@implementation TCAttributedTextScene
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0];
        
        _label = [[ASAttributedLabelNode alloc] initWithSize:CGSizeMake(900, 768)];
        _label.attributedString = [[NSAttributedString alloc] initWithString:@"hej" attributes:nil];
        _label.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        [self addChild:_label];
    }
    return self;
}
@end
