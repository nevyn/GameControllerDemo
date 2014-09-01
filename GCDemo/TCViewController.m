//
//  TCViewController.m
//  GCDemo
//
//  Created by Joachim Bengtsson on 2014-09-01.
//  Copyright (c) 2014 ThirdCog. All rights reserved.
//

#import "TCViewController.h"
#import "TCTextScene.h"
#import "TCImageScene.h"
#import "TCAttributedTextScene.h"
#import "TCGameScene.h"
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
			@"numberLabel.fontSize": @200,
			@"numberLabel.text": @"@nevyn",
			@"label.fontName": @"HelveticaNeue-Thin",
			@"label.text": @"+[GCController introGuide]",
			@"label.fontSize": @68,
		},
		
		
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.fontName": @"HelveticaNeue-UltraLight",
			@"numberLabel.fontSize": @700,
			@"numberLabel.text": @"1",
			@"label.text": @"Precision",
			@"label.fontSize": @100,
		},
		@{
			@"scene": [TCTextScene class],
			@"numberLabel.text": @"2",
			@"label.text": @"API 😍",
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.fontSize": @100,
		},
		@{
			@"scene": [TCTextScene class],
			@"numberLabel.text": @"3",
			@"label.text": @"😎",
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.fontSize": @100,
		},
		@{
			@"scene": [TCImageScene class],
			@"image": [UIImage imageNamed:@"standard"],
		},
		@{
			@"scene": [TCImageScene class],
			@"image": [UIImage imageNamed:@"extended"],
		},
		
		
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithHue:0.911 saturation:0.092 brightness:0.823 alpha:1.000],
			@"numberLabel.text": @"",
			@"label.fontName": @"HelveticaNeue-Thin",
			@"label.text": @"Connecting",
			@"label.fontSize": @80,
		},
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.fontName": @"HelveticaNeue-UltraLight",
			@"numberLabel.text": @"1",
			@"label.text": @"Listen for controller connection",
			@"label.fontSize": @80,
		},
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.fontName": @"HelveticaNeue-UltraLight",
			@"numberLabel.text": @"2",
			@"label.text": @"Remove on-screen control UI",
			@"label.fontSize": @80,
		},
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.fontName": @"HelveticaNeue-UltraLight",
			@"numberLabel.text": @"3",
			@"label.text": @"(Can't require hardware controllers)",
			@"label.fontSize": @70,
		},
		@{
			@"scene": [TCImageScene class],
			@"numberLabel.text": @"4",
			@"image": [UIImage imageNamed:@"4p"],
		},
		@{
			@"scene": [TCAttributedTextScene class],
			@"label.attributedString": [[NSAttributedString alloc] initWithFileURL:[[NSBundle mainBundle] URLForResource:@"code1" withExtension:@"rtf"] options:nil documentAttributes:nil error:NULL],
		},
		@{
			@"scene": [TCAttributedTextScene class],
			@"label.attributedString": [[NSAttributedString alloc] initWithFileURL:[[NSBundle mainBundle] URLForResource:@"code2" withExtension:@"rtf"] options:nil documentAttributes:nil error:NULL],
		},
		
		
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithHue:0.911 saturation:0.092 brightness:0.823 alpha:1.000],
			@"label.fontName": @"HelveticaNeue-Thin",
			@"numberLabel.text": @"",
			@"label.text": @"Getting Input",
			@"label.fontSize": @80,
		},
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.fontName": @"HelveticaNeue-UltraLight",
			@"numberLabel.text": @"1",
			@"label.text": @"Polling",
			@"label.fontSize": @90,
		},
		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithRed:0x99/255. green:0xd1/255. blue:0xef/255. alpha:1.0],
			@"label.fontName": @"HelveticaNeue-UltraLight",
			@"numberLabel.text": @"2",
			@"label.text": @"Event based",
			@"label.fontSize": @90,
		},
		
		@{
			@"scene": [TCGameScene class],
			@"label.attributedString": [[NSAttributedString alloc] initWithFileURL:[[NSBundle mainBundle] URLForResource:@"code3" withExtension:@"rtf"] options:nil documentAttributes:nil error:NULL],
		},
		@{
			@"scene": [TCGameScene class],
			@"label.attributedString": [[NSAttributedString alloc] initWithFileURL:[[NSBundle mainBundle] URLForResource:@"code4" withExtension:@"rtf"] options:nil documentAttributes:nil error:NULL],
		},



		@{
			@"scene": [TCTextScene class],
			@"backgroundColor": [UIColor colorWithHue:0.911 saturation:0.092 brightness:0.823 alpha:1.000],
			@"numberLabel.fontSize": @700,
			@"numberLabel.text": @"",
			@"label.fontName": @"HelveticaNeue-Thin",
			@"label.text": @"Thankyouuu",
			@"label.fontSize": @68,
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
		NSLog(@"Connecting controller %@", controller);
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
		_index = -1;
	[self switchToSceneIndex:++_index];
}
- (void)prevScene
{
	if(_index <= 0)
		_index = (int)_steps.count;
	[self switchToSceneIndex:--_index];
}
- (void)switchToSceneIndex:(int)index
{
	NSLog(@"Switching to scene %d", index);
	
	NSDictionary *step = _steps[index];
	
    // Create and configure the scene.
	Class klass = step[@"scene"];

	SKScene *scene = [(SKView*)self.view scene];
	if([scene class] != klass) {
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
