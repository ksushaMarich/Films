//
//  RespondViewController.swift
//  Films
//
//  Created by Ксения Маричева on 29.11.2024.
//

import UIKit

class FoundMoviesViewController: UIViewController {
    
    //MARK: - naming
    private let movies: [Movie]
    
    private lazy var FoundTableView: FilmsViewTableView = {
        let tableView = FilmsViewTableView(movies: movies)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - init
    init(movies: [Movie]) {
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup view methods
    private func setupView() {
        view.addSubview(FoundTableView)
        NSLayoutConstraint.activate([
            FoundTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FoundTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            FoundTableView.topAnchor.constraint(equalTo: view.topAnchor),
            FoundTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}
