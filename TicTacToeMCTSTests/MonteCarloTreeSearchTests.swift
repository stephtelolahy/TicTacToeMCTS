//
//  MonteCarloTreeSearchTests.swift
//  TicTacToeMCTSTests
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import XCTest

class MonteCarloTreeSearchTests: XCTestCase {
    
    private var sut: MTCS!
    
    override func setUp() {
        sut = MTCS()
    }

    func test_GivenEmptyBoard_whenSimulateInterAIPlay_thenGameDraw() {
        var board = Board(values: [[0, 0, 0],
                                   [0, 0, 0],
                                   [0, 0, 0]],
                          turn: Board.P1)
        while board.status == Status.IN_PROGRESS {
            board = sut.findBestMove(state: board)
        }
        XCTAssertEqual(board.status, Status.DRAW)
    }
}
