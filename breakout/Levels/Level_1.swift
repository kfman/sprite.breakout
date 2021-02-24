//
//  GameScene.swift
//  breakout
//
//  Created by Klaus Fischer on 09.01.21.
//

import SpriteKit
import GameplayKit

class Level_1: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var player: Player!
    private var ball: Ball!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.player = childNode(withName: "player") as? Player
        player.setup()
        self.ball = childNode(withName: "ball") as? Ball
        ball.setup()
        
        for child  in children{
                if ((child.userData?.value(forKey: "wall") as? Bool) ?? false){
                    child.physicsBody = SKPhysicsBody(rectangleOf: child.frame.size)
                    child.physicsBody!.affectedByGravity = false
                    child.physicsBody!.isDynamic = false
                    child.physicsBody?.categoryBitMask = 0x04
                }
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("Collision....\(contact.bodyA.categoryBitMask) and \(contact.bodyB.categoryBitMask)")
        print("Normal \(contact.contactNormal.dx):\(contact.contactNormal.dy)")
       
        
        let ball = contact.bodyA.categoryBitMask == 0x02 ? contact.bodyA : contact.bodyB
        let other = contact.bodyA.categoryBitMask != 0x02 ? contact.bodyA : contact.bodyB
        
        if other.categoryBitMask == 0x01 {
            let playerContact = convert(contact.contactPoint, to: player)
            print("hit player at \(playerContact.x * 3)")
            ball.velocity = CGVector(dx: playerContact.x * 3, dy: -ball.velocity.dy)
        } else {

            ball.velocity = CGVector(dx: (abs(contact.contactNormal.dx) > 0.5 ? -1.0 : 1.0) * ball.velocity.dx,
                                     dy: (abs(contact.contactNormal.dy) > 0.5 ? -1.0 : 1.0) * ball.velocity.dy)
        }
        
        if (contact.bodyB.categoryBitMask == 0x08){
            contact.bodyB.node?.removeFromParent()
        }
        
        if (contact.bodyA.categoryBitMask == 0x08){
            contact.bodyA.node?.removeFromParent()
        }
        

    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
            player.position = CGPoint(x: t.location(in: self).x, y: player.position.y)
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))
            player.position = CGPoint(x: t.location(in: self).x, y: player.position.y)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        ball.hit()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if ball.position.y < -200{
            let gameOver = SKSpriteNode(texture: SKTexture(image: #imageLiteral(resourceName: "gameover")))
            addChild(gameOver)
            isPaused = true
        }
    }
}
