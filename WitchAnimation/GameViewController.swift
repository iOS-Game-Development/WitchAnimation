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

        guard let view = self.view as? SKView else { return }
        let scene = GameScene(size: view.frame.size)
        
        scene.scaleMode = .aspectFill
        view.ignoresSiblingOrder = true
        view.presentScene(scene)
            
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
