//
//  State.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 01/06/2021.
//

// Defining two player turn based game state
protocol State {
    var turn: Int { get }
    var opponent: Int { get }
    var status: Int { get } // If status is equal to player then the he wins
    var possibleMoves: [Self] { get }
}

enum Status {
    static let IN_PROGRESS = -1
    static let DRAW = 0
}
