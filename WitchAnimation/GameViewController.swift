//
//  GameViewController.swift
//  WitchAnimation
//
//  Created by Hung Phan on 10/7/20.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        if let view = self.view as? SKView {
            let scene = GameScene(size: view.frame.size)
            print("width: \(UIScreen.main.bounds.width)")
            print("height: \(UIScreen.main.bounds.height)")
            
            
            scene.scaleMode = .aspectFill
            
            view.ignoresSiblingOrder = true
                
            view.showsFPS = true
            view.showsNodeCount = true
            // Present the scene
            view.presentScene(scene)
        }
            
    }
}
