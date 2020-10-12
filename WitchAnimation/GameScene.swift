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
    
    lazy var analogJoystick : AnalogJoystick = {
        let js = AnalogJoystick(diameter: 100, colors: nil, images: (UIImage(named: "jSubstrate"), UIImage(named: "jStick")))
        js.position = CGPoint(x: 90, y: 90)
        return js
    }()
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        buildWitch()
        animateWitch()
        setupJoystick()
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
    
}
