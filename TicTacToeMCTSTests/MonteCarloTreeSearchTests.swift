//
//  MonteCarloTreeSearchTests.swift
//  TicTacToeMCTSTests
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import XCTest

class MonteCarloTreeSearchTests: XCTestCase {
    
    private var sut: MTCSAi!
    
    override func setUp() {
        sut = MTCSAi()
    }

    func test_GivenEmptyBoard_whenSimulateInterAIPlay_thenGameDraw() {
        var board = Board(turn: Board.P1)
        
        while board.status == Status.IN_PROGRESS {
            board = sut.findBestMove(state: board)
            print(board.toString() + "\n")
        }
        
        print(board.toString() + "\n")
        
        XCTAssertEqual(board.status, Status.DRAW)
    }
    
    func test_GivenEmptyBoard_whenSimulateInterAIPlay_thenGameDraw2() {
        var board = Board(turn: Board.P2)
        
        while board.status == Status.IN_PROGRESS {
            board = sut.findBestMove(state: board)
            
            print(board.toString() + "\n")
        }
        
        print(board.toString() + "\n")
        
        XCTAssertEqual(board.status, Status.DRAW)
    }

}
