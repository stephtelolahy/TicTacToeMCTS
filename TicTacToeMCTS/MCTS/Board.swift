//
//  Board.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import Foundation

struct Position {
    let x: Int
    let y: Int
}

struct Board {
    
    static let IN_PROGRESS = -1
    static let DRAW = 0
    static let P1 = 1
    static let P2 = 2
    
    let values: [[Int]]
    
    init() {
        values = [[0, 0, 0],
                  [0, 0, 0],
                  [0, 0, 0]]
    }
    
    init(values: [[Int]]) {
        self.values = values
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
            return Board.DRAW
        } else {
            return Board.IN_PROGRESS
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
    
    func performMove(player: Int, p: Position) -> Board {
        var values = values
        values[p.x][p.y] = player
        return Board(values: values)
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
