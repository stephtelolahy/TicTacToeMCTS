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
        
        
        
        
        /*
         let boardSize = boardValues.count
         let maxIndex = boardSize - 1
         var diag1: [Int] = []
         var diag2: [Int] = []
         
         for i in 0...maxIndex {
         let row = boardValues[i]
         var col: [Int] = []
         for j in 0...maxIndex {
         col[j] = boardValues[j][i];
         }
         
         let checkRowForWin = checkForWin(row)
         if checkRowForWin != 0 {
         return checkRowForWin
         }
         
         int checkColForWin = checkForWin(col);
         if(checkColForWin!=0)
         return checkColForWin;
         
         diag1[i] = boardValues[i][i];
         diag2[i] = boardValues[maxIndex - i][i];
         }
         
         int checkDia1gForWin = checkForWin(diag1);
         if(checkDia1gForWin!=0)
         return checkDia1gForWin;
         
         int checkDiag2ForWin = checkForWin(diag2);
         if(checkDiag2ForWin!=0)
         return checkDiag2ForWin;
         
         if (getEmptyPositions().size() > 0)
         return IN_PROGRESS;
         else
         return DRAW;
         */
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
    
    func printBoard() {
        let size = values.count
        for i in 0..<size {
            print(values[i].map { "\($0)\t" })
        }
    }
    
    func printStatus() {
        switch status {
        case Self.P1:
            print("Player 1 wins")
            
        case Self.P2:
            print("Player 2 wins")
            
        case Self.DRAW:
            print("Game Draw")
            
        case Self.IN_PROGRESS:
            print("Game In Progress")
            
        default:
            fatalError("Illegal status")
        }
    }
}

extension Array where Element == Int {
    
    func commonValue() -> Element? {
        let firstValue = self[0]
        if self.allSatisfy({ $0 == firstValue }) {
            return firstValue
        } else {
            return nil
        }
    }
}
