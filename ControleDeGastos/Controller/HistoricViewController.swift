//
//  HistoricViewController.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 12/01/22.
//

import Foundation
import UIKit

class HistoricViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var historicItems = [HistoricModel]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 125
        tableView.register(HistoricViewCell.self,
                           forCellReuseIdentifier: HistoricViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        title = "Histórico"
        setLayout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historicItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoricViewCell.identifier, for: indexPath) as! HistoricViewCell
        cell.configure(with: historicItems[indexPath.row])
        return cell
    }
    
    func setLayout() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        historicItems = HistoricDAO.SelectAll() as! [HistoricModel]
        tableView.reloadData()
    }
}
