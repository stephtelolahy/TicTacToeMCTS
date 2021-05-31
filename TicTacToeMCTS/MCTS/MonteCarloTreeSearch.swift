//
//  MonteCarloTreeSearch.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import UIKit
import Foundation

enum MonteCarloTreeSearch {
    
    static let DEFAULT_ITERATIONS = 100
    static let WIN_SCORE = 20
    static let DRAW_SCORE = 10
    static let LOOSE_SCORE = 0
    
    static func findNextMove(board: Board, playerNo: Int, iterations: Int = DEFAULT_ITERATIONS) -> Board {
        let rootNode = Node(state: State(board: board, playerNo: playerNo))
        let opponent = 3 - playerNo
        
        for _ in 0..<iterations {
            // Phase 1 - Selection
            let promisingNode = selectPromisingNode(rootNode)
            
            // Phase 2 - Expansion
            if promisingNode.state.board.status == Board.IN_PROGRESS {
                expandNode(promisingNode)
            }
            
            // Phase 3 - Simulation
            var nodeToExplore = promisingNode
            if promisingNode.children.count > 0 {
                nodeToExplore = promisingNode.children.randomElement()!
            }
            let playoutResult = simulateRandomPlayout(nodeToExplore, playerNo: playerNo, opponent: opponent)
            
            // Phase 4 - Update
            backPropogation(nodeToExplore, result: playoutResult);
        }
        
        let winnerNode = findBestNodeWithScore(rootNode)
        return winnerNode.state.board
    }
}

private extension MonteCarloTreeSearch {
    
    static func selectPromisingNode(_ rootNode: Node) -> Node {
        var node = rootNode
        while node.children.count > 0 {
            node = findBestNodeWithUCT(node)
        }
        return node
    }
    
    static func expandNode(_ node: Node) {
        node.state.allPossibleStates().forEach {
            node.children.append(Node(state: $0, parent: node))
        }
    }
    
    static func simulateRandomPlayout(_ node: Node, playerNo: Int, opponent: Int) -> Int {
        var tempState = node.state
        var boardStatus = tempState.board.status
        
        // While not in terminal state
        while boardStatus == Board.IN_PROGRESS {
            tempState = tempState.allPossibleStates().randomElement()!
            boardStatus = tempState.board.status
        }
        
        if boardStatus == playerNo {
            return WIN_SCORE
        } else if boardStatus == opponent {
            return LOOSE_SCORE
        } else if boardStatus == Board.DRAW {
            return DRAW_SCORE
        } else {
            fatalError("Illegal state")
        }
    }
    
    static func backPropogation(_ nodeToExplore: Node, result: Int) {
        var tempNode: Node? = nodeToExplore
        while tempNode != nil {
            tempNode?.state.visitCount += 1
            tempNode?.state.totalScore += result
            tempNode = tempNode?.parent
        }
    }
    
    static func findBestNodeWithUCT(_ node: Node) -> Node {
        node.children.max { uctValue($0) < uctValue($1) }!
    }
    
    static func uctValue(_ node: Node) -> Double {
        let totalVisit = node.parent!.state.visitCount
        let totalScore = node.state.totalScore
        let visitCount = node.state.visitCount
        
        if visitCount == 0 {
            return Double(Int.max)
        }
        
        return Double(totalScore) / Double(visitCount) + 1.41 *  (log2(Double(totalVisit)) / Double(visitCount)).squareRoot()
    }
    
    static func findBestNodeWithScore(_ node: Node) -> Node {
        node.children.max { averageValue($0) < averageValue($1) }!
    }
    
    static func averageValue(_ node: Node) -> Double {
        Double(node.state.totalScore) / Double(node.state.visitCount)
    }
}
