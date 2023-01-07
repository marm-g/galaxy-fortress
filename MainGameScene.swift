//
//  MainGameScene.swift
//  GalaxyFortressTwo
//
//  Created by Reno DuBois on 1/6/23.
//

import SpriteKit
import GameplayKit

class MainGameScene: SKScene {
    var dice1: GKEntity?
    
    
    
    func createSceneContents() {
        dice1 = GKEntity()
        let visualComponent = VisualComponent(imageName: "d6_1")
        
        dice1!.addComponent(visualComponent)
        addChild(visualComponent.sprite)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("why must you make me do this")
    }
}
