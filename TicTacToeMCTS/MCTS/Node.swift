//
//  Node.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

class Node {
    let board: Board
    let player: Int
    let parent: Node?
    
    var visitCount: Int = 0
    var winCount: Int = 0
    var children: [Node] = []
    
    
    init(board: Board, player: Int, parent: Node? = nil) {
        self.board = board
        self.player = player
        self.parent = parent
    }
    
    func allPossibleStates() -> [Node] {
        board.emptyPositions.map {
            Node(board: board.performMove(player: player, p: $0),
                 player: 3 - player,
                 parent: self)
        }
    }
}
