//
//  DIContainer.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 01/06/2021.
//
// swiftlint:disable force_cast

import UIKit

enum DIContainer {

    static func provideInitialviewController() -> UIViewController {
        let navController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateInitialViewController() as! UINavigationController
        let nodeViewController = navController.viewControllers[0] as! NodeViewController

        let board = Board(values: [[0, 0, 0],
                                   [0, 2, 0],
                                   [0, 0, 0]],
                          turn: Board.P1)
        nodeViewController.node = MTCS().explore(state: board)
        return navController
    }

    static func provideNodeViewController(_ node: Node<Board>) -> UIViewController {
        let nodeViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "NodeViewController") as! NodeViewController
        nodeViewController.node = node
        return nodeViewController
    }
}
