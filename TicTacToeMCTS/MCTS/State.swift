//
//  State.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 01/06/2021.
//

// Defining two player turn based game state
protocol State {
    associatedtype Move

    var turn: Int { get }
    var opponent: Int { get }
    var status: Int { get } // If status is equal to player then the he wins
    var possibleMoves: [Move] { get }

    func performMove(_ move: Move) -> Self
}

enum Status {
    static let inProgress = -1
    static let draw = 0
}
