//
//  VisualComponent.swift
//  GalaxyFortressTwo
//
//  Created by Reno DuBois on 1/6/23.
//

import GameplayKit

class VisualComponent: GKComponent {
    public var sprite: SKSpriteNode
    public var imageName: String
    
    init(imageName: String, pos: CGPoint) {
        self.sprite = SKSpriteNode(imageNamed: imageName)
        
        self.imageName = imageName
        self.sprite.position = pos
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
    
    func changeSprite(imageName: String) {
        self.sprite.texture = SKTexture(imageNamed: imageName)
        self.imageName = imageName
    }
}
