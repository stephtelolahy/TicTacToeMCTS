//
//  Board.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//
// swiftlint:disable identifier_name

import Foundation

struct Board: State, Equatable {

    struct Position: Equatable {
        let x: Int
        let y: Int
    }

    static let P1 = 1
    static let P2 = 2

    let values: [[Int]]
    let turn: Int

    var status: Int {
        var lines: [[Int]] = []
        // rows
        lines.append([values[0][0], values[0][1], values[0][2]])
        lines.append([values[1][0], values[1][1], values[1][2]])
        lines.append([values[2][0], values[2][1], values[2][2]])

        // columns
        lines.append([values[0][0], values[1][0], values[2][0]])
        lines.append([values[0][1], values[1][1], values[2][1]])
        lines.append([values[0][2], values[1][2], values[2][2]])

        // diagonals
        lines.append([values[0][0], values[1][1], values[2][2]])
        lines.append([values[0][2], values[1][1], values[2][0]])

        for line in lines {
            if let win = line.commonValue() {
                return win
            }
        }

        if possibleMoves.isEmpty {
            return Status.draw
        } else {
            return Status.inProgress
        }
    }

    var possibleMoves: [Position] {
        let size = values.count
        var result: [Position] = []
        for i in 0..<size {
            for j in 0..<size where values[i][j] == 0 {
                result.append(Position(x: i, y: j))
            }
        }
        return result
    }

    func performMove(_ position: Position) -> Board {
        var values = values
        values[position.x][position.y] = turn
        return Board(values: values, turn: 3 - turn)
    }
}

extension Array where Element == Int {

    func commonValue() -> Element? {
        let firstValue = self[0]
        if firstValue != 0,
           self.allSatisfy({ $0 == firstValue }) {
            return firstValue
        } else {
            return nil
        }
    }
}

extension Board {

    func toString() -> String {
        let displayText: [String] = [".", "0", "X"]

        return values.map { row in
            row.map { "\(displayText[$0])\t" }.joined()
        }
        .joined(separator: "\n")
    }
}
