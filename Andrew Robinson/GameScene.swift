//
//  GameScene.swift
//  Andrew Robinson
//
//  Created by Andrew Robinson on 4/19/15.
//  Copyright (c) 2015 Andrew Robinson. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    
    var circles : [SKShapeNode] = [SKShapeNode]()
    
    var xVelocity: CGFloat = 0
    
    var kMaxLeft : CGFloat = 0
    var kMaxRight : CGFloat = 0
    var kMaxBottom : CGFloat = 0
    var kMaxTop : CGFloat = 0
    
    override func didMoveToView(view: SKView) {
        
        let minusSize : CGFloat = 40
        
        // Set variables
        kMaxLeft = CGFloat((3/4)*self.frame.size.width) + minusSize
        kMaxRight = self.frame.size.width/4 - minusSize
        kMaxBottom = self.frame.size.height/4 - minusSize
        kMaxTop = CGFloat((3/4)*self.frame.size.height) + minusSize
        
        var circle = self.circle();
        
        self.addChild(circle)
        circle.physicsBody?.applyForce(CGVectorMake(50, 50))
        circles.append(circle)
        
        // Create the loop
        self.spawnMore();
        
        // No gravity!
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect:self.frame)
        
    }
    
    func circle() -> SKShapeNode {
        
        var circleRadius : CGFloat
        let randRadius : UInt32 = arc4random_uniform(3)
        
        var color : SKColor
        let randColor : UInt32 = arc4random_uniform(3)
        
        switch randRadius {
        case 0:
            circleRadius = 50
        case 1:
            circleRadius = 30
        case 2:
            circleRadius = 20
        default:
            circleRadius = 10
        }
        
        switch randColor {
        case 0:
            color = SKColor.blueColor()
        case 1:
            color = SKColor.purpleColor()
        case 2:
            color = SKColor.redColor()
        default:
            color = SKColor.blackColor()
        }
        
        var circle = SKShapeNode(circleOfRadius:circleRadius) // Size of Circle
        circle.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        circle.physicsBody = SKPhysicsBody(circleOfRadius:circleRadius)
        circle.physicsBody!.dynamic = true
        circle.strokeColor = SKColor.clearColor()
        circle.fillColor = color
        
        return circle;
        
    }
    
    func spawnMore() {
        
        if circles.count < 10 {
            
            delay(1) {
                var circle = self.circle();
                
                self.addChild(circle)
                circle.physicsBody?.applyForce(CGVectorMake(-500, -500))
                self.circles.append(circle)
                
                self.spawnMore();
            }
            
        }
        
    }
    
    // MARK: Update
    
    override func update(currentTime: CFTimeInterval) {
        
        // Move!
        for sprite : SKShapeNode in circles {
            
            if sprite.position.x > kMaxLeft {
                sprite.physicsBody?.applyImpulse(CGVectorMake(-30, 0))
            }
            
            if sprite.position.x < kMaxRight {
                sprite.physicsBody?.applyImpulse(CGVectorMake(30, 0))
            }
            
            if sprite.position.y < kMaxBottom {
                sprite.physicsBody?.applyImpulse(CGVectorMake(0, 30))
            }
            
            if sprite.position.y > kMaxTop {
                sprite.physicsBody?.applyImpulse(CGVectorMake(0, -30))
            }
            
        }
        
    }
    
    // MARK: Delay
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
   
}
