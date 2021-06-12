//
//  MTCSAi.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import UIKit
import Foundation

class MTCS {
    
    private static let DEFAULT_ITERATIONS = 1000
    
    func findBestMove<T: State>(state: T, iterations: Int = DEFAULT_ITERATIONS) -> T {
        let rootNode = explore(state: state, iterations: iterations)
        let bestNode = rootNode.children.max { $0.visitCount < $1.visitCount }!
        return bestNode.state
    }
    
    func explore<T: State>(state: T, iterations: Int = DEFAULT_ITERATIONS) -> Node<T> {
        let rootNode = Node(state: state)
        let player = state.turn
        let opponent = state.opponent
        
        for _ in 0..<iterations {
            // Phase 1 - Selection
            var nodeToExplore = selectPromisingNode(rootNode)
            
            // Phase 2 - Expansion
            if nodeToExplore.state.status == Status.IN_PROGRESS {
                expandNode(nodeToExplore)
                nodeToExplore = nodeToExplore.children.randomElement()!
            }
            
            // Phase 3 - Simulation
            let playoutResult = simulateRandomPlayout(nodeToExplore, player: player, opponent: opponent)
            
            // Phase 4 - Update
            backPropogation(nodeToExplore, result: playoutResult)
        }
        
        return rootNode
    }
}

private extension MTCS {
    
    func selectPromisingNode<T: State>(_ rootNode: Node<T>) -> Node<T> {
        var node = rootNode
        while !node.children.isEmpty {
            node = node.children.max { $0.uctValue < $1.uctValue }!
        }
        return node
    }
    
    func expandNode<T: State>(_ node: Node<T>) {
        node.state.possibleMoves.forEach {
            node.children.append(Node(state: $0, parent: node))
        }
    }
    
    func simulateRandomPlayout<T: State>(_ nodeToExplore: Node<T>, player: Int, opponent: Int) -> Int {
        if nodeToExplore.state.status == opponent {
            /*
             https://medium.com/swlh/tic-tac-toe-at-the-monte-carlo-a5e0394c7bc2
             If the node results in an opponent’s victory, it would mean that if the player had made the selected move, his opponent will have a subsequent move that can result in the opponents immediete victory. Because the move the player chose can lead to a definite loss, the function lowers the parents node’s winScore to the lowest possible integer to prevent future moves to that node. Otherwise the algorithm alternates random moves between the two player until the board results in a game ending state. The function then returns the final game status.
             */
            nodeToExplore.parent?.winCount = Int.min
            return 0
        }
        
        var node = nodeToExplore
        while node.state.status == Status.IN_PROGRESS {
            let randomMove = node.state.possibleMoves.randomElement()!
            node = Node(state: randomMove)
        }
        
        if node.state.status == player {
            return 1
        } else {
            return 0
        }
    }
    
    func backPropogation<T: State>(_ nodeToExplore: Node<T>, result: Int) {
        var node: Node<T>? = nodeToExplore
        while node != nil {
            node?.visitCount += 1
            node?.winCount += result
            node = node?.parent
        }
    }
}

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

private extension Node {
    
    var uctValue: Double {
        if visitCount == 0 {
            return Double(Int.max)
        }
        
        return Double(winCount) / Double(visitCount) + 1.41 *  sqrt(log2(Double(parent!.visitCount)) / Double(visitCount))
    }
}
