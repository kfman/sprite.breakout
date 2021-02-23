//
//  Ball.swift
//  breakout
//
//  Created by Klaus Fischer on 09.01.21.
//

import SpriteKit

class Ball: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        physicsBody = SKPhysicsBody(circleOfRadius: 10)
        physicsBody!.categoryBitMask = 0x02
        physicsBody!.collisionBitMask = 0x00
        physicsBody!.contactTestBitMask = 0xFF
        physicsBody!.applyImpulse(CGVector(dx: -0.5, dy: -1))
        physicsBody!.linearDamping = 0
        physicsBody!.angularDamping = 0
    }
    
    func hit(){
        //self.physicsBody!.applyImpulse(CGVector(dx:0, dy:50))
    }
    
}
