//
//  State.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

class State {
    let board: Board
    var playerNo: Int
    var visitCount: Int
    var winScore: Double
    
    
    init(board: Board, playerNo: Int) {
        self.board = board
        self.playerNo = playerNo
        self.visitCount = 0
        self.winScore = 0
    }
    
    var opponent: Int {
        3 - playerNo
    }
    
    func allPossibleStates() -> [State] {
        board.emptyPositions.map { position in
            let newPlayer = opponent
            let newBoard = Board(values: board.values)
            newBoard.performMove(player: newPlayer, p: position)
            return State(board: newBoard, playerNo: newPlayer)
        }
    }
    
    func incrementVisit() {
        visitCount += 1
    }
    
    func addScore(score: Double) {
        if winScore != Double(Int.min) {
            winScore += score;
        }
    }
    
    func randomPlay() {
        board.performMove(player: playerNo, p: board.emptyPositions.randomElement()!)
    }
    
    func togglePlayer() {
        playerNo = opponent
    }
}

