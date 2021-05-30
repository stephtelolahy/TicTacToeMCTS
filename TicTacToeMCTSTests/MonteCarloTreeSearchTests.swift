//
//  MonteCarloTreeSearchTests.swift
//  TicTacToeMCTSTests
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import XCTest

class MonteCarloTreeSearchTests: XCTestCase {

    func test_GivenEmptyBoard_whenSimulateInterAIPlay_thenGameDraw() {
        var board = Board()
        var player = Board.P1
        while board.status == Board.IN_PROGRESS {
            print(board.toString())
            print(board.statusString())
            
            board = MonteCarloTreeSearch.findNextMove(board: board, playerNo: player)
            player = 3 - player
        }
        
        XCTAssertEqual(board.status, Board.DRAW)
    }

}
