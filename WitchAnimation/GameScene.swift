//
//  GameScene.swift
//  WitchAnimation
//
//  Created by Hung Phan on 10/7/20.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    private var witch = SKSpriteNode()
    private var witchMovingFrames : [SKTexture] = []
    private var fireButton1 = SKSpriteNode()
    private var fireButton2 = SKSpriteNode()
    private var fireButton3 = SKSpriteNode()
    private var background1 : SKSpriteNode!
    private var background2 : SKSpriteNode!
    
    lazy var analogJoystick : AnalogJoystick = {
        let js = AnalogJoystick(diameter: 100, colors: nil, images: (UIImage(named: "jSubstrate"), UIImage(named: "jStick")))
        js.position = CGPoint(x: 90, y: 90)
        return js
    }()
    
    override func didMove(to view: SKView) {
        backgroundColor = .systemBlue
        buildBackground()
        buildWitch()
        animateWitch()
        setupJoystick()
        addFireButton()
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveBackground()
    }
    
    func buildWitch() {
        let witchAnimatedAtlas = SKTextureAtlas(named: "WitchImages")
        var moveFrames : [SKTexture] = []
        let numImages = witchAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let witchTextureName = "witch\(i)"
            moveFrames.append(witchAnimatedAtlas.textureNamed(witchTextureName))
        }
        witchMovingFrames = moveFrames
        let firstFrameTexture = witchMovingFrames[0]
        witch = SKSpriteNode(texture: firstFrameTexture)
        witch.position = CGPoint(x: witch.size.width, y: frame.midY)
        addChild(witch)
    }
    
    func animateWitch() {
        witch.run(SKAction.repeatForever(SKAction.animate(with: witchMovingFrames, timePerFrame: 0.1, resize: false, restore: true)), withKey: "movingWitchInPlace")
    }
    
    func setupJoystick() {
        addChild(analogJoystick)
        analogJoystick.trackingHandler = { [unowned self] data in
            self.witch.position = CGPoint(x: self.witch.position.x + (data.velocity.x * 0.12), y: self.witch.position.y + (data.velocity.y * 0.12))
            
        }
    }
    
    func addFireButton() {
        fireButton1 = SKSpriteNode(imageNamed: "button1")
        fireButton1.name = "button1"
        fireButton1.position = CGPoint(x: UIScreen.main.bounds.width * 4/5, y: 70)
        self.addChild(fireButton1)
        
        fireButton2 = SKSpriteNode(imageNamed: "button2")
        fireButton2.name = "button2"
        fireButton2.position = CGPoint(x: UIScreen.main.bounds.width * 4/5 + 60, y: 70)
        self.addChild(fireButton2)
        
        fireButton3 = SKSpriteNode(imageNamed: "button3")
        fireButton3.name = "button3"
        fireButton3.position = CGPoint(x: UIScreen.main.bounds.width * 4/5 + 120, y: 70)
        self.addChild(fireButton3)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = (touch?.location(in: self))!
        
        for touchedNode in self.nodes(at: location) {
            if touchedNode == fireButton1 || touchedNode == fireButton2 || touchedNode == fireButton3 {
                fadeFireButton(button: touchedNode as! SKSpriteNode)
                fireFireball()
            }
        }
    }
    
    func fireFireball() {
        let fireballNode = SKSpriteNode(imageNamed: "fireball")
        fireballNode.position = self.witch.position
        fireballNode.position.x += 5
        self.addChild(fireballNode)
        
        let animationDuration : TimeInterval = 1
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: self.frame.size.width, y: self.witch.position.y), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        fireballNode.run(SKAction.sequence(actionArray))
    }
    
    func fadeFireButton(button : SKSpriteNode) {
        var fadeOut = SKAction.fadeAlpha(to: 0.1, duration: 0.1)
        var fadeIn = SKAction.fadeAlpha(to: 1, duration: 0.1)
        
        button.run(SKAction.sequence([fadeOut, fadeIn]))
    }
    
    func buildBackground() {
        background1 = SKSpriteNode(imageNamed: "background1")
        background1.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        background1.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        background1.zPosition = -1000
        background1.name = "background1"
        addChild(background1)
        
        background2 = SKSpriteNode(imageNamed: "background2")
        background2.size = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        background2.position = CGPoint(x: (self.frame.size.width / 2) + background1.size.width, y: self.frame.size.height / 2)
        background2.zPosition = -1000
        background2.name = "background2"
        addChild(background2)

    }
    
    func moveBackground() {
        background1.position = CGPoint(x: background1.position.x - 2, y: background1.position.y)
        background2.position = CGPoint(x: background2.position.x - 2, y: background2.position.y)

        
        if (background1.position.x <= -(background1.size.width / 2)) {
            background1.position = CGPoint(x: (self.frame.size.width / 2) + background2.size.width, y: background1.position.y)
        }
        if (background2.position.x <= -(background2.size.width / 2)) {
            background2.position = CGPoint(x: (self.frame.size.width / 2) + background1.size.width, y: background2.position.y)
        }
    }
    
}
