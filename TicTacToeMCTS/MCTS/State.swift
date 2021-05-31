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
    var totalScore: Int
    
    init(board: Board, playerNo: Int) {
        self.board = board
        self.playerNo = playerNo
        self.visitCount = 0
        self.totalScore = 0
    }
    
    func allPossibleStates() -> [State] {
        board.emptyPositions.map {
            State(board: board.performMove(player: playerNo, p: $0),
                  playerNo: 3 - playerNo)
        }
    }
}
