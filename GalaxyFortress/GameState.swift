//
//  GameState.swift
//  GalaxyFortress
//
//  Created by Reno DuBois on 12/28/22.
//

import GameplayKit


typealias Roll = (Int, Int)
enum RollChoice {
    case combined, separate
}


class GameState: ObservableObject {
    var players: [Player]
    var lastRoll: (Int, Int) = (0, 0)
    // rollingPlayer is the player who is currently the "dice roller"
    // activePlayer is the one who should be taking actions on the device
    var rollingPlayer: Int!
    var activePlayer: Int!
    
    func roll() {
        let dist = GKRandomDistribution.d6()
        lastRoll = (dist.nextInt(), dist.nextInt())
    }
    
    func assignFirstPlayer() {
        self.rollingPlayer = self.players.randomElement()!
        self.activePlayer = self.rollingPlayer
    }
    
    static func printRoll(r: Roll) -> String {
        return "(" + String(r.0) + "," + String(r.1) + ")"
    }
    
    func doTurn (choice: RollChoice) {
        let sector1 = activePlayer.cards[lastRoll.0 - 1]
        // TODO(reno): Make these 'Equatable' so we can just do player == activePlayer
        if activePlayer.name == rollingPlayer.name {
            print(sector1?.activeCard.mainAction)
        } else {
            for card in sector1!.flippedCards {
                print(card.flippedAction)
            }
        }
        
    }
    
    init(players: [Player]) {
        // TODO(reno): error if players is empty
        self.players = players
    }
    
    init() {
        let player1 = Player(name: "Player 1", cards: starterDeck)
        let player2 = Player(name: "Player 2", cards: starterDeck)
        self.players = []
        self.players.append(player1)
        self.players.append(player2)
        self.assignFirstPlayer()
    }
}

class Player {
    var name: String!
    var credits = 0
    var income = 0
    var victoryPoints = 0
    // TODO(reno): Cards need to be represented. This should be by "slot" (1-12)
    // but we need to hold a single card as the "active" one, and an array of
    // cards for the "flipped" ones.
    var cards: [Int: Sector]
    
    init(name: String, cards: [Int: Sector], credits: Int = 0, income: Int = 0, victoryPoints: Int = 0) {
        self.name = name
        self.credits = credits
        self.income = income
        self.victoryPoints = victoryPoints
        self.cards = cards
    }
}

class Sector {
    var activeCard: Card
    var flippedCards: [Card]
    
    init(active: Card, flipped: [Card] = []) {
        self.activeCard = active
        self.flippedCards = flipped
    }
}

class Card {
    var mainAction: Action
    var flippedAction: Action
    var sector: Int // TODO(reno): these can only be 1-12, specify this somehow
    var id: Int
    var name: String
    
    init(mainAction: Action, flippedAction: Action, sector: Int, id: Int, name: String) {
        self.mainAction = mainAction
        self.flippedAction = flippedAction
        self.sector = sector
        self.id = id
        self.name = name
    }
}

// TODO(reno): This isn't a good way to represent actions. There's a few types:
// BASIC: simply adds x to a specific resource.
// CHARGE SKILL: If selected, will just charge (handling skills might be worth doing seperately?)
// OTHER: other things that operate in some other way
// For now, I can just implement basic actions, but all they need to know is what resource to change,
// and how much to add to it.
enum ActionType {
    case basic
}

enum ResourceType {
    case credit
    case income
    case victoryPoint
}

class Action {
    var type: ActionType
    
    init(type: ActionType) {
        self.type = type
    }
}

class BasicAction: Action {
    var resource: ResourceType
    var amount: Int
    
    init(resource: ResourceType, amount: Int) {
        self.resource = resource
        self.amount = amount
        super.init(type: .basic)
    }
}


let oneCredit = BasicAction(resource: .credit, amount: 1)
let twoCredits = BasicAction(resource: .credit, amount: 2)
let threeCredits = BasicAction(resource: .credit, amount: 3)
let fourCredits = BasicAction(resource: .credit, amount: 4)
let fiveCredits = BasicAction(resource: .credit, amount: 5)
let oneIncome = BasicAction(resource: .income, amount: 1)

let starterCard1 = Card(mainAction: oneCredit, flippedAction: oneCredit, sector: 1, id: 1, name: "Starter Card 1")
let starterCard2 = Card(mainAction: oneCredit, flippedAction: oneCredit, sector: 2, id: 2, name: "Starter Card 2")
let starterCard3 = Card(mainAction: oneCredit, flippedAction: oneCredit, sector: 3, id: 3, name: "Starter Card 3")
let starterCard4 = Card(mainAction: oneCredit, flippedAction: oneCredit, sector: 4, id: 4, name: "Starter Card 4")
let starterCard5 = Card(mainAction: oneCredit, flippedAction: oneCredit, sector: 5, id: 5, name: "Starter Card 5")
let starterCard6 = Card(mainAction: oneCredit, flippedAction: oneCredit, sector: 6, id: 6, name: "Starter Card 6")
let starterCard7 = Card(mainAction: threeCredits, flippedAction: twoCredits, sector: 7, id: 7, name: "Starter Card 7")
let starterCard8 = Card(mainAction: threeCredits, flippedAction: twoCredits, sector: 8, id: 8, name: "Starter Card 8")
let starterCard9 = Card(mainAction: oneIncome, flippedAction: threeCredits, sector: 9, id: 9, name: "Starter Card 9")
let starterCard10 = Card(mainAction: oneIncome, flippedAction: threeCredits, sector: 10, id: 10, name: "Starter Card 10")
let starterCard11 = Card(mainAction: oneIncome, flippedAction: fourCredits, sector: 11, id: 11, name: "Starter Card 11")
let starterCard12 = Card(mainAction: oneIncome, flippedAction: fiveCredits, sector: 12, id: 12, name: "Starter Card 12")

let starterDeck = [
    1: Sector(active: starterCard1),
    2: Sector(active: starterCard2),
    3: Sector(active: starterCard3),
    4: Sector(active: starterCard4),
    5: Sector(active: starterCard5),
    6: Sector(active: starterCard6),
    7: Sector(active: starterCard7),
    8: Sector(active: starterCard8),
    9: Sector(active: starterCard9),
    10: Sector(active: starterCard10),
    11: Sector(active: starterCard11),
    12: Sector(active: starterCard12),
]
