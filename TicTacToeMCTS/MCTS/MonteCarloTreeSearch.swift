//
//  MonteCarloTreeSearch.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import UIKit
import Foundation

enum MonteCarloTreeSearch {
    
    static let WIN_SCORE = 10
    static let DEFAULT_ITERATIONS = 1000
    
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
            if !promisingNode.children.isEmpty {
                nodeToExplore = promisingNode.getRandomChildNode()
            }
            let playoutResult = simulateRandomPlayout(nodeToExplore, opponent: opponent)
            
            // Phase 4 - Update
            backPropogation(nodeToExplore, playerNo: playoutResult);
        }
        
        let winnerNode = rootNode.getChildWithMaxScore()
        return winnerNode.state.board
    }
}

private extension MonteCarloTreeSearch {
    
    static func selectPromisingNode(_ rootNode: Node) -> Node {
        var node = rootNode
        while (!node.children.isEmpty) {
            node = UCT.findBestNodeWithUCT(node)
        }
        return node
    }
    
    static func expandNode(_ node: Node) {
        node.state.allPossibleStates().forEach {
            node.children.append(Node(state: $0, parent: node))
        }
    }
    
    static func simulateRandomPlayout(_ node: Node, opponent: Int) -> Int {
        let tempNode = Node(node: node)
        var tempState = tempNode.state
        var boardStatus = tempState.board.status
        
        if boardStatus == opponent {
            tempNode.parent?.state.winScore = Double(Int.min)
            return boardStatus
        }
        
        while boardStatus == Board.IN_PROGRESS {
            tempState = tempState.allPossibleStates().randomElement()!
            boardStatus = tempState.board.status
        }
        
        return boardStatus
    }
    
    static func backPropogation(_ nodeToExplore: Node, playerNo: Int) {
        var tempNode: Node? = nodeToExplore
        while tempNode != nil {
            tempNode?.state.incrementVisit()
            if tempNode?.state.playerNo == playerNo {
                tempNode?.state.addScore(score: Double(Self.WIN_SCORE))
            }
            tempNode = tempNode?.parent
        }
    }
}

private enum UCT {
    
    static func findBestNodeWithUCT(_ node: Node) -> Node {
        let parentVisit = node.state.visitCount
        return node.children.max { n1, n2 in
            let score1 = UCT.uctValue(totalVisit: parentVisit, nodeWinScore: n1.state.winScore, nodeVisit: n1.state.visitCount)
            let score2 = UCT.uctValue(totalVisit: parentVisit, nodeWinScore: n2.state.winScore, nodeVisit: n2.state.visitCount)
            return score1 < score2
        }!
    }
    
    static func uctValue(totalVisit: Int, nodeWinScore: Double, nodeVisit: Int) -> Double {
        if (nodeVisit == 0) {
            return Double(Int.max)
        }
        
        let fNodeVisit = Double(nodeVisit)
        let fTotalVisit = Double(totalVisit)
        let result = nodeWinScore / fNodeVisit + 1.41 *  (log2(fTotalVisit) / fNodeVisit).squareRoot()
        
        return result
    }
}

