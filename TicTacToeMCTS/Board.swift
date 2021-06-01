//
//  Board.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import Foundation

struct Board: State, Equatable {
    
    static let P1 = 1
    static let P2 = 2
    
    struct Position {
        let x: Int
        let y: Int
    }
    
    let values: [[Int]]
    let turn: Int
    
    init(values: [[Int]] =  [[0, 0, 0],
                             [0, 0, 0],
                             [0, 0, 0]],
         turn: Int = Board.P1) {
        self.values = values
        self.turn = turn
    }
    
    var opponent: Int {
        3 - turn
    }
    
    var status: Int {
        var rows: [[Int]] = []
        // rows
        rows.append([values[0][0], values[0][1], values[0][2]])
        rows.append([values[1][0], values[1][1], values[1][2]])
        rows.append([values[2][0], values[2][1], values[2][2]])
        
        // columns
        rows.append([values[0][0], values[1][0], values[2][0]])
        rows.append([values[0][1], values[1][1], values[2][1]])
        rows.append([values[0][2], values[1][2], values[2][2]])
        
        // diagonals
        rows.append([values[0][0], values[1][1], values[2][2]])
        rows.append([values[0][2], values[1][1], values[2][0]])
        
        for row in rows {
            if let win = row.winValue() {
                return win
            }
        }
        
        if emptyPositions.isEmpty {
            return Status.DRAW
        } else {
            return Status.IN_PROGRESS
        }
    }
    
    var allPossibleMoves: [Board] {
        emptyPositions.map {
            performMove($0)
        }
    }
    
    var emptyPositions: [Position] {
        let size = values.count
        var result: [Position] = []
        for i in 0..<size {
            for j in 0..<size {
                if values[i][j] == 0 {
                    result.append(Position(x: i, y: j))
                }
            }
        }
        return result
    }
    
    func performMove(_ position: Position) -> Board {
        var values = values
        values[position.x][position.y] = turn
        return Board(values: values, turn: opponent)
    }
}

extension Array where Element == Int {
    
    func winValue() -> Element? {
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
