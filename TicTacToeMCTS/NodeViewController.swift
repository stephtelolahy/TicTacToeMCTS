//
//  NodeViewController.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import UIKit

class NodeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var node: Node!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = node.player == Board.P1 ? "O" : "X"
    }
}

extension NodeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        node.children.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NodeCell") as! NodeCell
        
        let childNode = node.children[indexPath.row]
        let bestVisit = node.children.map { $0.visitCount }.max()!
        let isBest = childNode.visitCount == bestVisit
        
        cell.update(childNode, isBest: isBest)
        return cell
    }
}

extension NodeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let childNode = node.children[indexPath.row]
        let nodeVC = DIContainer.provideNodeViewController(childNode)
        navigationController?.pushViewController(nodeVC, animated: true)
    }
}


class NodeCell: UITableViewCell {
 
    @IBOutlet weak var boardLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func update(_ node: Node, isBest: Bool) {
        boardLabel.text = node.board.toString()
        infoLabel.text = "\(node.winCount)/\(node.visitCount)"
        
        if node.board.status == Board.IN_PROGRESS {
            backgroundColor = isBest ? .yellow : .white
        } else {
            backgroundColor = .green
        }
    }
}
