//
//  MonteCarloTreeSearch.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import UIKit
import Foundation

class MonteCarloTreeSearch {
    
    static let DEFAULT_ITERATIONS = 80
    
    func findNextMove(board: Board, player: Int, iterations: Int = DEFAULT_ITERATIONS) -> Board {
        let rootNode = _findNextMove(board: board, player: player)
        let winnerNode = findBestNodeWithScore(rootNode)
        return winnerNode.board
    }
    
    func _findNextMove(board: Board, player: Int, iterations: Int = DEFAULT_ITERATIONS) -> Node {
        let rootNode = Node(board: board, player: player)
        let opponent = 3 - player
        
        for _ in 0..<iterations {
            // Phase 1 - Selection
            var nodeToExplore = selectPromisingNode(rootNode)
            
            // Phase 2 - Expansion
            if nodeToExplore.board.status == Board.IN_PROGRESS {
                expandNode(nodeToExplore)
                nodeToExplore = nodeToExplore.children.randomElement()!
            }
            
            // Phase 3 - Simulation
            let playoutResult = simulateRandomPlayout(nodeToExplore, player: player, opponent: opponent)
            
            // Phase 4 - Update
            backPropogation(nodeToExplore, result: playoutResult);
        }
        
        return rootNode
    }
}

private extension MonteCarloTreeSearch {
    
    func selectPromisingNode(_ rootNode: Node) -> Node {
        var node = rootNode
        while node.children.count > 0 {
            node = findBestNodeWithUCT(node)
        }
        return node
    }
    
    func expandNode(_ node: Node) {
        node.allPossibleStates().forEach {
            node.children.append($0)
        }
    }
    
    func simulateRandomPlayout(_ nodeToExplore: Node, player: Int, opponent: Int) -> Int {
        
        if nodeToExplore.board.status == opponent {
            nodeToExplore.parent?.winCount = -1000
            return 0
        }
        
        var node = nodeToExplore
        while node.board.status == Board.IN_PROGRESS {
            node = node.allPossibleStates().randomElement()!
        }
        
        if node.board.status == player {
            return 1
        } else {
            return 0
        }
    }
    
    func backPropogation(_ nodeToExplore: Node, result: Int) {
        var node: Node? = nodeToExplore
        while node != nil {
            node?.visitCount += 1
            node?.winCount += result
            node = node?.parent
        }
    }
    
    func findBestNodeWithUCT(_ node: Node) -> Node {
        node.children.max { $0.uctValue < $1.uctValue }!
    }
    
    func findBestNodeWithScore(_ node: Node) -> Node {
        node.children.max { $0.visitCount < $1.visitCount }!
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
