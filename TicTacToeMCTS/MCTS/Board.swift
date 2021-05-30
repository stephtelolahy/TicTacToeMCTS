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

class Board {
    
    static let IN_PROGRESS = -1
    static let DRAW = 0
    static let P1 = 1
    static let P2 = 2
    
    var values: [[Int]]
    var totalMoves: Int
    
    init() {
        values = [[0, 0, 0],
                  [0, 0, 0],
                  [0, 0, 0]]
        totalMoves = 0
    }
    
    init(values: [[Int]]) {
        self.values = values
        totalMoves = 0
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
            if let win = row.commonValue() {
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
    
    func performMove(player: Int, p: Position) {
        values[p.x][p.y] = player
        totalMoves += 1
    }
}

extension Board {
    
    func toString() -> String {
        values.map { row in
            row.map { "\($0)\t" }.joined()
        }
        .joined(separator: "\n")
    }
    
    func statusString() -> String {
        switch status {
        case Self.P1:
            return "Player 1 wins"
            
        case Self.P2:
            return "Player 2 wins"
            
        case Self.DRAW:
            return "Game Draw"
            
        case Self.IN_PROGRESS:
            return "Game In Progress"
            
        default:
            fatalError("Illegal status")
        }
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
