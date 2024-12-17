//
//  ViewController.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - naming
    private var popularMovies: [Movie]?
    
    private lazy var mainView: MainTableView = {
        let view = MainTableView(movies: popularMovies ?? [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.moviesDataSource = self
        return view
    }()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            self.popularMovies = try await NetworkManager.shared.searchMovies()
            setupView()
        }
    }
    
    //MARK: - setupViewMethods
    
    private func setupView() {
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension MainViewController: MainTableViewDataSource {
    var movies: [Movie] { popularMovies ?? [] }
}

