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
        let phys = SKPhysicsBody(circleOfRadius: 10)
        phys.affectedByGravity = true
        phys.allowsRotation = false
        phys.isDynamic = true
        phys.friction = 0
        phys.restitution = 1.0
        
        physicsBody = phys
    
        
        physicsBody!.applyImpulse(CGVector(dx: 0, dy: 10))
    }
    
    func hit(){
        self.physicsBody!.applyImpulse(CGVector(dx:0, dy:50))
    }
    
}
