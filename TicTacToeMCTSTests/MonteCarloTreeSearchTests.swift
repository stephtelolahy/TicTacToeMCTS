//
//  MonteCarloTreeSearchTests.swift
//  TicTacToeMCTSTests
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import XCTest

class MonteCarloTreeSearchTests: XCTestCase {
    
    private var sut: MonteCarloTreeSearch!
    
    override func setUp() {
        sut = MonteCarloTreeSearch()
    }

    func test_GivenEmptyBoard_whenSimulateInterAIPlay_thenGameDraw() {
        var board = Board()
        var player = Board.P1
        
        while board.status == Board.IN_PROGRESS {
            board = sut.findNextMove(board: board, player: player)
            player = 3 - player
            
            print(board.toString() + "\n")
        }
        
        print(board.toString() + "\n")
        
        XCTAssertEqual(board.status, Board.DRAW)
    }

}
