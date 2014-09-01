//
//  TCGameScene.m
//  GCDemo
//
//  Created by Joachim Bengtsson on 2014-09-01.
//  Copyright (c) 2014 ThirdCog. All rights reserved.
//

#import "TCGameScene.h"
#import <GameController/GameController.h>

enum {
    CollisionPlayer = 1<<1,
    CollisionGround = 1<<2,
    CollisionBullet = 1<<3,
};

@interface TCGamePlayerSprite : SKSpriteNode
@property(nonatomic) BOOL touchingGround;
@property(nonatomic) SKSpriteNode *gun;
@end

@implementation TCGamePlayerSprite
@end

@interface TCGameScene () <SKPhysicsContactDelegate>
@end

@implementation TCGameScene
{
	SKNode *_game;
	SKSpriteNode *_floor1;
	SKSpriteNode *_floor2;
	NSMutableDictionary *_playerSprites;
	
}

-(id)initWithSize:(CGSize)size {    
	if(!(self = [super initWithSize:size]))
		return nil;
	
	_game = [[SKNode alloc] init];
	_game.alpha = 0;
	[self addChild:_game];
	
	_floor1 = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(1024, 20)];
	_floor1.position = CGPointMake(512, 10);
	_floor1.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:(CGRect){.origin={.x=-_floor1.frame.size.width/2, .y=-_floor1.frame.size.height/2}, .size=_floor1.frame.size}];
	_floor1.physicsBody.categoryBitMask = CollisionGround;
	[_game addChild:_floor1];
	
	_floor2 = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(500, 10)];
	_floor2.position = CGPointMake(552, 110);
	_floor2.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:(CGRect){.origin={.x=-_floor2.frame.size.width/2, .y=-_floor2.frame.size.height/2}, .size=_floor2.frame.size}];
	_floor2.physicsBody.categoryBitMask = CollisionGround;
	[_game addChild:_floor2];
	
	_playerSprites = [NSMutableDictionary new];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupControllers:) name:GCControllerDidConnectNotification object:nil];
	[self setupControllers:nil];
	
	_game.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:(CGRect){.size=size}];
	_game.physicsBody.categoryBitMask = CollisionGround;
	self.physicsWorld.contactDelegate = self;
	
	return self;
}

- (void)setupControllers:(NSNotification*)notif
{
	for(GCController *controller in [GCController controllers]) {
		NSLog(@"Game controller %@", controller);

		NSInteger playerIndex = controller.playerIndex;
		
		// new player!
		TCGamePlayerSprite *playerNode = _playerSprites[@(playerIndex)];
		if(!playerNode) {
			playerNode = [TCGamePlayerSprite spriteNodeWithColor:@[
				[UIColor redColor],
				[UIColor orangeColor],
				[UIColor brownColor],
				[UIColor whiteColor],
			][controller.playerIndex] size:CGSizeMake(20, 50)];
			playerNode.alpha = 0;
			_playerSprites[@(playerIndex)] = playerNode;
			playerNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(20, 50)];
			playerNode.physicsBody.allowsRotation = NO;
			playerNode.physicsBody.categoryBitMask = CollisionPlayer;
			playerNode.physicsBody.contactTestBitMask = CollisionGround;
			playerNode.physicsBody.restitution = 0.01;
			
			playerNode.gun = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(10, 10)];
			playerNode.gun.position = CGPointMake(10, 5);
			[playerNode addChild:playerNode.gun];
			[_game addChild:playerNode];
		}
		
		controller.gamepad.buttonA.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
			[self jump:playerIndex];
		};
		controller.gamepad.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
			[self shoot:playerIndex];
		};
	}
}

static float frandom() {
	return arc4random_uniform(1000)/1000.;
}

- (void)jump:(NSInteger)playerIndex
{
	TCGamePlayerSprite *player = _playerSprites[@(playerIndex)];
	
	// Dead? Respawn.
	if(player.alpha == 0) {
		player.position = CGPointMake(frandom()*1024, frandom()*400);
		player.alpha = 1;
		_game.alpha = 1;
		return;
	}
	
	if(!player.touchingGround)
		return;
	
	CGVector vel = player.physicsBody.velocity;
	vel.dy = 100;
	player.physicsBody.velocity = vel;
	[player.physicsBody applyImpulse:CGVectorMake(0, 20)];
	
}

- (void)shoot:(NSInteger)playerIndex
{
	TCGamePlayerSprite *player = _playerSprites[@(playerIndex)];
	if(player.alpha == 0) // dead
		return;
}

- (void)update:(NSTimeInterval)currentTime
{
	for(GCController *controller in [GCController controllers]) {
		TCGamePlayerSprite *player = _playerSprites[@(controller.playerIndex)];
		
		if(player.alpha == 0) // dead
			continue;

		
		float xAxisValue = controller.gamepad.dpad.xAxis.value;
		player.physicsBody.velocity = CGVectorMake(xAxisValue*400, player.physicsBody.velocity.dy);
		
		if(xAxisValue > 0) {
			player.gun.position = CGPointMake(10, 5);
		} else if(xAxisValue < 0) {
			player.gun.position = CGPointMake(-10, 5);
		}
	}
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
	TCGamePlayerSprite *sprite = (id)contact.bodyA.node;
	if(![sprite isKindOfClass:[TCGamePlayerSprite class]])
		sprite = (id)contact.bodyB.node;
	if(![sprite isKindOfClass:[TCGamePlayerSprite class]])
		return;
	
	sprite.touchingGround = YES;
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
	TCGamePlayerSprite *sprite = (id)contact.bodyA.node;
	if(![sprite isKindOfClass:[TCGamePlayerSprite class]])
		sprite = (id)contact.bodyB.node;
	if(![sprite isKindOfClass:[TCGamePlayerSprite class]])
		return;
	
	sprite.touchingGround = NO;
}
@end
