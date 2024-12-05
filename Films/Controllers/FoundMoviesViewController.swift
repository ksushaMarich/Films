//
//  RespondViewController.swift
//  Films
//
//  Created by Ксения Маричева on 29.11.2024.
//

import UIKit

class FoundMoviesViewController: UIViewController {
    
    //MARK: - naming
    
    private lazy var respondTableView: FilmsViewTableView = {
        let tableView = FilmsViewTableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - init
    init() {
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup view methods
    private func setupView() {
        view.addSubview(respondTableView)
        NSLayoutConstraint.activate([
            respondTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            respondTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            respondTableView.topAnchor.constraint(equalTo: view.topAnchor),
            respondTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
