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
    
    
}
