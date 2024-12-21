//
//  ViewController.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //соответствует приложению данных. Он занимается обработкой данных, их хранением и получением (например, из API или базы данных).
    
    //MARK: - naming
    private var popularMovies: [Movie] = []
    private lazy var movies: [Movie] = []
    
    private lazy var networkManager = NetworkManager.shared
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        view.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        view.allowsSelection = false
        return view
    }()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            self.popularMovies = try await networkManager.searchMovies()
            setupView()
        }
    }
    
    //MARK: - setup view methods
    
    private func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    //methods
    private func updateWithPopularMovies() {
        
    }
}





extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderTableView()
        header.delegate = self
        return section == 0 ? header : nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 10 : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        cell.configure(with: popularMovies[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { popularMovies.count }
}

extension MainViewController: HeaderTableViewDelegate {
    func update(with query: String) {
        
        func search(withClosure: Bool, with query: String ) {
            
            guard !query.isEmpty else {
                updateWithPopularMovies()
                return
            }
            
            guard withClosure else {
                Task {
                    let movies = try await networkManager.searchMovies(query: query)
                    self.movies = movies
                    tableView.reloadData()
                }
                return
            }
            networkManager.searchMoviesWithClosure(for: query) { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Ошибка: \(error.localizedDescription)")
                    self.updateWithPopularMovies()
                }
            }
        }
        
        search(withClosure: true, with: query)
    }
}

