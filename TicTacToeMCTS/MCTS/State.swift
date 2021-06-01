//
//  State.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 01/06/2021.
//

protocol State {
    var turn: Int { get }
    var opponent: Int { get }
    var status: Int { get }
    var allPossibleMoves: [Self] { get }
}

enum Status {
    static let IN_PROGRESS = -1
    static let DRAW = 0
}
