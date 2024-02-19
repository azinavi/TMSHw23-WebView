//
//  Bookmarks.swift
//  WebView
//
//  Created by azinavi on 17/2/24.
//

import UIKit

class Bookmarks: UIViewController {
    
    var tableView = UITableView()
    var sites: [String] = []
    var array: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        title = "Bookmarks"
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LinkCellTableViewCell.self, forCellReuseIdentifier: "LinkCellTableViewCell")
        tableView.reloadData()
        tableView.backgroundColor = .black
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
