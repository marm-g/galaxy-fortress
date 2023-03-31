//
//  GalaxyFortressTwoTests.swift
//  GalaxyFortressTwoTests
//
//  Created by Reno DuBois on 1/6/23.
//

import XCTest
@testable import GalaxyFortress

final class GalaxyFortressTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSeparateIncomeActionsWorkCorrectly() {
        let state = GameState()
        state.lastRoll = (1, 1)
        state.doTurn(choice: .separate)
        XCTAssertEqual(state.players[0].credits, 2, "Credits were not 2.")
    }
    
    func testCombinedIncomeActionsWorkCorrectly() {
        let state = GameState()
        state.lastRoll = (3,4)
        state.doTurn(choice: .combined)
        XCTAssertEqual(state.players[0].credits, 3, "Credits were not 3.")
    }
    
    func testFlippingCardWorks() {
        let state = GameState()
        // card 13 is a 1C, 1C on Sector 1
        state.players[0].addCard(card: cards[13]!)
        XCTAssertEqual(state.players[0].cards[1]?.flippedCards.count, 1, "Number of flipped cards in sector one was not 1.")
    }
    
    func testFlippedCardActions() {
        let state = GameState()
        // card 14 is a 5C, 1C on Sector 2
        // 5C is there to ensure that we're not using the non-flipped values here
        state.players[0].addCard(card: cards[14]!)
        state.lastRoll = (1,1)
        state.rollingPlayer = 1
        state.doTurn(choice: .combined)
        XCTAssertEqual(state.players[0].credits, 1)
    }

}
