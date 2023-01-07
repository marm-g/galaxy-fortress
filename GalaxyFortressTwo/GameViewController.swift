//
//  GameViewController.swift
//  GalaxyFortressTwo
//
//  Created by Reno DuBois on 1/6/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as! SKView
        view.presentScene(MainGameScene(size: CGSize(width: 100, height: 100)))
        view.showsFPS = true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
