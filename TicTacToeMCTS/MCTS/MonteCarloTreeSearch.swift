//
//  MonteCarloTreeSearch.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import UIKit
import Foundation

class MonteCarloTreeSearch {
    
    static let DEFAULT_ITERATIONS = 100
    
    func findNextMove(board: Board, player: Int, iterations: Int = DEFAULT_ITERATIONS) -> Board {
        let rootNode = Node(board: board, player: player)
        let opponent = 3 - player
        
        for _ in 0..<iterations {
            // Phase 1 - Selection
            let promisingNode = selectPromisingNode(rootNode)
            
            // Phase 2 - Expansion
            if promisingNode.board.status == Board.IN_PROGRESS {
                expandNode(promisingNode)
            }
            
            // Phase 3 - Simulation
            var nodeToExplore = promisingNode
            if promisingNode.children.count > 0 {
                nodeToExplore = promisingNode.children.randomElement()!
            }
            let playoutResult = simulateRandomPlayout(nodeToExplore, player: player, opponent: opponent)
            
            // Phase 4 - Update
            backPropogation(nodeToExplore, result: playoutResult);
        }
        
        let winnerNode = findBestNodeWithScore(rootNode)
        return winnerNode.board
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
        var node = nodeToExplore
        while node.board.status == Board.IN_PROGRESS {
            node = node.allPossibleStates().randomElement()!
        }
        return node.board.status
    }
    
    func backPropogation(_ nodeToExplore: Node, result: Int) {
        var node: Node? = nodeToExplore
        while node != nil {
            node?.visitCount += 1
            
            if result == node?.player {
                node?.winCount += 1
            }
            
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
        
        return Double(winCount) / Double(visitCount) + 1.41 *  (log2(Double(parent!.visitCount)) / Double(visitCount)).squareRoot()
    }
}
