//
//  GameScene.swift
//  Avalanche
//
//  Created by Sean Lawrence on 10/28/15.
//  Copyright (c) 2015 Sean Lawrence. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    
    static let spike : UInt32 = 1
    
    static let player : UInt32 = 2
    
}

class GameScene: SKScene {
    
    var player = SKSpriteNode(imageNamed: "blackbox.png")
    
    override func didMoveToView(view: SKView) {
        
        /*Setup your scene here*/
        
        player.xScale = 0.5
        
        player.yScale = 0.5
        
        //sets up position of player in the middle of screen a little above bottom
        player.position = CGPointMake(self.size.width / 2, self.size.height / 5)
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: player.size)
        
        player.physicsBody?.affectedByGravity = false
        
        player.physicsBody?.categoryBitMask = PhysicsCategory.player
        
        player.physicsBody?.collisionBitMask = PhysicsCategory.spike
        
        //generates spikes at random positions
        var spikeTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("spawnSpikes"), userInfo: nil, repeats: true)
        
        self.addChild(player)
        
    }
    
    func spawnSpikes() {
        
        var spike = SKSpriteNode(imageNamed: "blacktriangle.png")
        
        spike.xScale = 0.5
        
        spike.yScale = 0.5
        
        var minValue = self.size.width / 8
        
        var maxValue = self.size.width - 20
        
        //UInt32 allows for more precision
        var spawnPoint = UInt32(maxValue - minValue)
        
        spike.position = CGPoint(x: CGFloat(arc4random_uniform(spawnPoint)), y: self.size.height)
        
        let action = SKAction.moveToY(-70, duration: 2.0)
        
        spike.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(spike)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            player.position.x = location.x
            
        }
    }
    
    //allows us to drag player along x-axis
    /*func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            
            let location = touch.locationInNode(self)
            
            player.position.x = location.x
            
        }
        
    }*/
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
