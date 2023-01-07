//
//  VisualComponent.swift
//  GalaxyFortressTwo
//
//  Created by Reno DuBois on 1/6/23.
//

import GameplayKit

class VisualComponent: GKComponent {
    public var sprite: SKSpriteNode
    public var position: CGPoint
    
    init(imageName: String) {
        self.sprite = SKSpriteNode(imageNamed: imageName)
        self.position = self.sprite.position
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
