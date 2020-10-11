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
            
//        if let view = self.view as? SKView {
//            let scene = GameScene(size: view.frame.size)
//            print("width: \(UIScreen.main.bounds.width)")
//            print("height: \(UIScreen.main.bounds.height)")
//
//
//            scene.scaleMode = .aspectFill
//            scene.size = view.bounds.size
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//            // Present the scene
//            view.presentScene(scene)
//        }
        guard let view = self.view as? SKView else { return }
        let scene = GameScene(size: view.frame.size)
        
        view.ignoresSiblingOrder = true
        view.presentScene(scene)
            
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
