//
//  Node.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

class Node {
    let state: State
    let parent: Node?
    var children: [Node]
    
    init(node: Node) {
        self.state = node.state
        self.children = node.children
        self.parent = node.parent
    }
    
    init(state: State, parent: Node? = nil) {
        self.state = state
        self.children = []
        self.parent = parent
    }
}
