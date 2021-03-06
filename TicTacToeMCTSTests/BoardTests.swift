//
//  BoardTests.swift
//  TicTacToeMCTSTests
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import XCTest

class BoardTests: XCTestCase {

    func test_InitialBoardIsInProgress() {
        // Given
        let values = [[0, 0, 0],
                      [0, 0, 0],
                      [0, 0, 0]]
        // When
        let sut = Board(values: values, turn: Board.P1)

        // Assert
        XCTAssertEqual(sut.values, [[0, 0, 0],
                                    [0, 0, 0],
                                    [0, 0, 0]])
        XCTAssertEqual(sut.status, Status.inProgress)
    }

    func test_InitializeBoardWithValues() {
        // Given
        let values = [[0, 1, 1],
                      [0, 0, 1],
                      [2, 2, 1]]

        // When
        let sut = Board(values: values, turn: Board.P1)

        // Assert
        XCTAssertEqual(sut.values, values)
    }

    func test_ValueChanges_IfApplyMove() {
        // Given
        let values = [[0, 1, 1],
                      [0, 0, 1],
                      [2, 2, 1]]
        let sut = Board(values: values, turn: Board.P1)

        // When
        let output = sut.performMove(Board.Position(x: 0, y: 0))

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
        let sut = Board(values: values, turn: Board.P1)

        // When
        // Assert
        XCTAssertEqual(sut.status, Status.inProgress)
    }

    func test_Draw_IfNoPositionEmpty() {
        // Given
        let values = [[2, 2, 1],
                      [1, 1, 2],
                      [2, 1, 2]]
        let sut = Board(values: values, turn: Board.P1)

        // When
        // Assert
        XCTAssertEqual(sut.status, Status.draw)
    }

    func test_Win_IfSamePlayerOnARow() {
        // Given
        let values = [[0, 1, 1],
                      [0, 0, 1],
                      [2, 2, 2]]
        let sut = Board(values: values, turn: Board.P1)

        // When
        // Assert
        XCTAssertEqual(sut.status, Board.P2)
    }

    func test_Win_IfSamePlayerOnAColumn() {
        // Given
        let values = [[0, 0, 1],
                      [0, 2, 1],
                      [2, 0, 1]]
        let sut = Board(values: values, turn: Board.P1)

        // When
        // Assert
        XCTAssertEqual(sut.status, Board.P1)
    }

    func test_Win_IfSamePlayerOnADiagonal1() {
        // Given
        let values = [[1, 0, 2],
                      [0, 1, 2],
                      [2, 0, 1]]
        let sut = Board(values: values, turn: Board.P1)

        // When
        // Assert
        XCTAssertEqual(sut.status, Board.P1)
    }

    func test_Win_IfSamePlayerOnADiagonal2() {
        // Given
        let values = [[0, 0, 2],
                      [0, 2, 1],
                      [2, 0, 1]]
        let sut = Board(values: values, turn: Board.P1)

        // When
        // Assert
        XCTAssertEqual(sut.status, Board.P2)
    }

}
