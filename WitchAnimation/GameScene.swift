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
    
    override func didMove(to view: SKView) {
        backgroundColor = .white
        buildWitch()
        animateWitch()
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
}
