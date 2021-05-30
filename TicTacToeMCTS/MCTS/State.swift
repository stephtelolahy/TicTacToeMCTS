//
//  State.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

class State {
    let board: Board
    let playerNo: Int
    var visitCount: Int
    var winScore: Double
    
    init(board: Board, playerNo: Int) {
        self.board = board
        self.playerNo = playerNo
        self.visitCount = 0
        self.winScore = 0
    }
    
    func allPossibleStates() -> [State] {
        board.emptyPositions.map {
            State(board: board.performMove(player: playerNo, p: $0),
                  playerNo: 3 - playerNo)
        }
    }
    
    func incrementVisit() {
        visitCount += 1
    }
    
    func addScore(score: Double) {
        guard winScore != Double(Int.min) else {
            return
        }
        
        winScore += score
    }
}
