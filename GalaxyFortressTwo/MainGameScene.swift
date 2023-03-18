//
//  MainGameScene.swift
//  GalaxyFortressTwo
//
//  Created by Reno DuBois on 1/6/23.
//

import SpriteKit
import GameplayKit

class MainGameScene: SKScene {
    var dice1: GKEntity!
    var dice2: GKEntity!
    var dice1Result: Int = 1
    var dice2Result: Int = 1
    var rollButton: GKEntity!
    var separateButton: GKEntity!
    var combinedButton: GKEntity!
    var gameEntities: [GKEntity]
    var contentCreated: Bool = false
    var lastUpdateTime: TimeInterval = 0
    
    func createDiceEntity(pos: CGPoint) -> GKEntity {
        let newDice = GKEntity()
        let visualComponent = VisualComponent(imageName: "d6_1", pos: pos)
        newDice.addComponent(visualComponent)
        addChild(visualComponent.sprite)
        
        gameEntities.append(newDice)
        return newDice
    }

    func createSceneContents() {
        dice1 = createDiceEntity(pos: CGPoint(x: 400, y: 500))
        dice2 = createDiceEntity(pos: CGPoint(x: 500, y: 500))
        // Adding them as entities, but the visual components won't get rendered until
        // the dice get rolled, inside of displayDiceChoiceButtons
        separateButton = GKEntity()
        combinedButton = GKEntity()
        rollButton = GKEntity()
        gameEntities.append(rollButton)
        gameEntities.append(separateButton)
        gameEntities.append(combinedButton)
        let textComponent = TextComponent(text: "Roll Dice", pos: CGPoint(x: 450, y: 420))
        let buttonOnClick = ClickableComponent {
            self.rollDice()
            self.displayDiceChoiceButtons()
        }
        rollButton.addComponent(textComponent)
        rollButton.addComponent(buttonOnClick)
        addChild(textComponent.label)
    }
    
    override func didMove(to view: SKView) {
        if !contentCreated {
            createSceneContents()
            contentCreated = true
        }
    }
    
    func selectResult(firstResult: Int, secondResult: Int?) {
        // first result
        // select current player, activate sector at that number
        
        // if second result
        // select current player, activate sector at that number
    }
    
    func rollDice() {
        let dist = GKRandomDistribution(forDieWithSideCount: 6)
        dice1Result = dist.nextInt()
        dice2Result = dist.nextInt()
        print(dice1Result, dice2Result)
        dice1.component(ofType: VisualComponent.self)?.changeSprite(imageName: "d6_" + String(dice1Result))
        dice2.component(ofType: VisualComponent.self)?.changeSprite(imageName: "d6_" + String(dice2Result))
        return
    }
    
    func displayDiceChoiceButtons () {
        let separateButtonText = String(format: "%d, %d", dice1Result, dice2Result)
        let combinedButtonText = String(format: "%d", dice1Result + dice2Result)
        let sepTextComponent = TextComponent(text: separateButtonText, pos: CGPoint(x: 400, y: 350))
        let combinedTextComponent = TextComponent(text: combinedButtonText, pos: CGPoint(x: 500, y: 350))
        let sepClickable = ClickableComponent(callback: {
            print("separate numbers")
            self.hideDiceChoiceButtons()
        })
        let combinedClickable = ClickableComponent(callback: {
            print("combined numbers")
            self.hideDiceChoiceButtons()
        })
        separateButton.addComponent(sepTextComponent)
        combinedButton.addComponent(combinedTextComponent)
        separateButton.addComponent(sepClickable)
        combinedButton.addComponent(combinedClickable)
        addChild(sepTextComponent.label)
        addChild(combinedTextComponent.label)
    }
    
    func hideDiceChoiceButtons () {
        separateButton.component(ofType: TextComponent.self)?.label.removeFromParent()
        combinedButton.component(ofType: TextComponent.self)?.label.removeFromParent()
        separateButton.removeComponent(ofType: TextComponent.self)
        combinedButton.removeComponent(ofType: TextComponent.self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        dice1.update(deltaTime: currentTime)
        for component in dice1.components {
            component.update(deltaTime: currentTime)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // NOTE(reno): this might be the most garbage click handling system ever but it works!
        for t in touches {
            let location = t.location(in: self)
            let touchedNode = atPoint(location)
            for entity in gameEntities {
                if let visualComponent = entity.component(ofType: VisualComponent.self) {
                    if touchedNode.isEqual(to: visualComponent.sprite) {
                        if let clickableComponent = entity.component(ofType: ClickableComponent.self) {
                            clickableComponent.callback()
                        }
                        break
                    }
                } else if let textComponent = entity.component(ofType: TextComponent.self) {
                    if touchedNode.isEqual(to: textComponent.label) {
                        if let clickableComponent = entity.component(ofType: ClickableComponent.self) {
                            clickableComponent.callback()
                        }
                        break
                    }
                }
            }
        }
    }
    
    override init(size: CGSize) {
        self.gameEntities = []
        super.init(size: size)
        self.scaleMode = .aspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("why must you make me do this")
    }
}
