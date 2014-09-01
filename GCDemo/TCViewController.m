//
//  TCViewController.m
//  GCDemo
//
//  Created by Joachim Bengtsson on 2014-09-01.
//  Copyright (c) 2014 ThirdCog. All rights reserved.
//

#import "TCViewController.h"
#import "TCTextScene.h"
#import <GameController/GameController.h>

@implementation TCViewController
{
	NSArray *_steps;
	int _index;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	_steps = @[
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithHue:0.911 saturation:0.092 brightness:0.823 alpha:1.000],
			@"label.text": @"+[GCController introGuide]",
			@"label.fontSize": @60,
		},
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.text": @"1. Precision",
			@"label.fontSize": @80,
		},
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.text": @"2. API 😍",
			@"label.fontSize": @80,
		},
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.text": @"3. 😎",
			@"label.fontSize": @80,
		},

	];
	
	_index = -1;
	[self nextScene];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupControllers:) name:GCControllerDidConnectNotification object:nil];
	[GCController startWirelessControllerDiscoveryWithCompletionHandler:nil];
}
- (void)setupControllers:(NSNotification*)notif
{
	int i = 0;
	for(GCController *controller in [GCController controllers]) {
		if(controller.playerIndex == GCControllerPlayerIndexUnset)
			controller.playerIndex = i++;
		
		__block BOOL prevDebounce = NO;
		controller.gamepad.leftShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
			if(pressed && !prevDebounce) {
				[self prevScene];
				prevDebounce = YES;
			} else if(!pressed && prevDebounce) {
				prevDebounce = NO;
			}
		};
		
		__block BOOL nextDebounce = NO;
		controller.gamepad.rightShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
			if(pressed && !nextDebounce) {
				[self nextScene];
				nextDebounce = YES;
			} else if(!pressed && nextDebounce) {
				nextDebounce = NO;
			}
		};
	}
}

- (void)nextScene
{
	if(_index == _steps.count-1)
		return;
	[self switchToSceneIndex:++_index];
}
- (void)prevScene
{
	if(_index <= 0)
		return;
	[self switchToSceneIndex:--_index];
}
- (void)switchToSceneIndex:(int)index
{
	NSLog(@"Switching to scene %d", index);
	
	NSDictionary *step = _steps[index];
	
    // Create and configure the scene.
	Class klass = step[@"scene"];

	SKScene *scene = [(SKView*)self.view scene];
	if(![scene isKindOfClass:klass]) {
		scene = [klass sceneWithSize:self.view.bounds.size];
		scene.scaleMode = SKSceneScaleModeAspectFill;
		[(SKView*)self.view presentScene:scene];
	}
	
	for(NSString *key in step) {
		if([key isEqual:@"scene"])
			continue;
		[scene setValue:step[key] forKeyPath:key];
	}
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}
@end
