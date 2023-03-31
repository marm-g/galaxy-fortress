//
//  TextComponent.swift
//  GalaxyFortressTwo
//
//  Created by Reno DuBois on 3/4/23.
//

import GameplayKit

class TextComponent: GKComponent {
    public var label: SKLabelNode
    
    init(text: String, pos: CGPoint) {
        self.label = SKLabelNode(text: text)
        self.label.position = pos
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}

