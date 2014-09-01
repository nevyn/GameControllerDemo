//
//  TCImageScene.m
//  GCDemo
//
//  Created by Joachim Bengtsson on 2014-09-01.
//  Copyright (c) 2014 ThirdCog. All rights reserved.
//

#import "TCImageScene.h"

@implementation TCImageScene
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0];
        
        _sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship.png"];
        _sprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:_sprite];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
	_image = image;
	
	_sprite.texture = [SKTexture textureWithImage:image];
	_sprite.size = image.size;
}

@end
