//
//  TCMyScene.m
//  GCDemo
//
//  Created by Joachim Bengtsson on 2014-09-01.
//  Copyright (c) 2014 ThirdCog. All rights reserved.
//

#import "TCTextScene.h"

@implementation TCTextScene
{
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0];
        
        _label = [SKLabelNode labelNodeWithFontNamed:@"HelveticaNeue-UltraLight"];
        _label.text = @"Hello, World!";
        _label.fontSize = 30;
        _label.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
		_label.fontColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1];
        
        [self addChild:_label];
    }
    return self;
}
@end
