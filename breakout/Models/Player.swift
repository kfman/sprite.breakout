//
//  Player.swift
//  breakout
//
//  Created by Klaus Fischer on 09.01.21.
//

import SpriteKit

class Player: SKSpriteNode{
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        physicsBody = SKPhysicsBody.init(rectangleOf: size)
        physicsBody!.affectedByGravity = false
        physicsBody!.isDynamic = false
        physicsBody!.allowsRotation = false
        physicsBody!.categoryBitMask = 0x01
        physicsBody!.collisionBitMask = 0
        physicsBody?.isResting = true
    }
}
