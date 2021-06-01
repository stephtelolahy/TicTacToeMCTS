//
//  Node.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

class Node<T: State> {
    let state: T
    let parent: Node?
    var children: [Node] = []
    var visitCount: Int = 0
    var winCount: Int = 0
    
    init(state: T, parent: Node? = nil) {
        self.state = state
        self.parent = parent
    }
}
