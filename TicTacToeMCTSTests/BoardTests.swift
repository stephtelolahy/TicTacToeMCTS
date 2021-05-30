//
//  BoardTests.swift
//  TicTacToeMCTSTests
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import XCTest

class BoardTests: XCTestCase {
    
    func test_InitializeEmptyBoard() {
        // Given
        // When
        let sut = Board()
        
        // Assert
        XCTAssertEqual(sut.values, [[0, 0, 0],
                                    [0, 0, 0],
                                    [0, 0, 0]])
    }
    
    func test_InitialBoardIsInProgress() {
        // Given
        // When
        let sut = Board()
        
        // Assert
        XCTAssertEqual(sut.values, [[0, 0, 0],
                                    [0, 0, 0],
                                    [0, 0, 0]])
        XCTAssertEqual(sut.status, Board.IN_PROGRESS)
    }
    
    func test_InitializeBoardWithValues() {
        // Given
        let values = [[0, 1, 1],
                      [0, 0, 1],
                      [2, 2, 1]]
        
        // When
        let sut = Board(values: values)
        
        // Assert
        XCTAssertEqual(sut.values, values)
    }
    
    func test_ValueChanges_IfApplyMove() {
        // Given
        let values = [[0, 1, 1],
                      [0, 0, 1],
                      [2, 2, 1]]
        let sut = Board(values: values)
        
        // When
        let output = sut.performMove(player: 1, p: Position(x: 0, y: 0))
        
        // Assert
        XCTAssertEqual(output.values, [[1, 1, 1],
                                       [0, 0, 1],
                                       [2, 2, 1]])
    }
    
    func test_InProgress_IfSomePositionsEmpty() {
        // Given
        let values = [[0, 1, 1],
                      [0, 0, 1],
                      [2, 0, 2]]
        let sut = Board(values: values)
        
        // When
        // Assert
        XCTAssertEqual(sut.status, Board.IN_PROGRESS)
    }
    
    func test_Draw_IfNoPositionEmpty() {
        // Given
        let values = [[2, 2, 1],
                      [1, 1, 2],
                      [2, 1, 2]]
        let sut = Board(values: values)
        
        // When
        // Assert
        XCTAssertEqual(sut.status, Board.DRAW)
    }
    
    func test_Win_IfSamePlayerOnARow() {
        // Given
        let values = [[0, 1, 1],
                      [0, 0, 1],
                      [2, 2, 2]]
        let sut = Board(values: values)
        
        // When
        // Assert
        XCTAssertEqual(sut.status, Board.P2)
    }
    
    func test_Win_IfSamePlayerOnAColumn() {
        // Given
        let values = [[0, 0, 1],
                      [0, 2, 1],
                      [2, 0, 1]]
        let sut = Board(values: values)
        
        // When
        // Assert
        XCTAssertEqual(sut.status, Board.P1)
    }
    
    func test_Win_IfSamePlayerOnADiagonal1() {
        // Given
        let values = [[1, 0, 2],
                      [0, 1, 2],
                      [2, 0, 1]]
        let sut = Board(values: values)
        
        // When
        // Assert
        XCTAssertEqual(sut.status, Board.P1)
    }
    
    func test_Win_IfSamePlayerOnADiagonal2() {
        // Given
        let values = [[0, 0, 2],
                      [0, 2, 1],
                      [2, 0, 1]]
        let sut = Board(values: values)
        
        // When
        // Assert
        XCTAssertEqual(sut.status, Board.P2)
    }
    
}
