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
    
    override func didMoveToView(view: SKView) {
        
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
        
        var circle = SKShapeNode(circleOfRadius:50) // Size of Circle
        circle.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        circle.physicsBody = SKPhysicsBody(circleOfRadius:50)
        circle.physicsBody!.dynamic = true
        circle.strokeColor = SKColor.clearColor()
        circle.fillColor = SKColor.blueColor()
        
        return circle;
        
    }
    
    func spawnMore() {
        
        if circles.count < 5 {
            
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
//        let rate: CGFloat = 0.5; //Controls rate of motion. 1.0 instantaneous, 0.0 none.
//        
//        for sprite : SKShapeNode in circles {
//            let relativeVelocity: CGVector = CGVector(dx:xVelocity-sprite.physicsBody!.velocity.dx, dy:0);
//            sprite.physicsBody!.velocity=CGVector(dx:sprite.physicsBody!.velocity.dx+relativeVelocity.dx*rate, dy:0);
//        }
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
