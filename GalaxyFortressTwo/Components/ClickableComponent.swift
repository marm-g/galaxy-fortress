//
//  ClickableComponent.swift
//  GalaxyFortressTwo
//
//  Created by Reno DuBois on 3/2/23.
//

import GameplayKit

class ClickableComponent: GKComponent {
    public var callback: () -> Void
    
    init(callback: @escaping () -> Void) {
        self.callback = callback
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
    }
}
