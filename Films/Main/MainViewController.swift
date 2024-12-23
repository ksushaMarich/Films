//
//  ViewController.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func searchMovies(with query: String) async -> [Movie]
}

class MainViewController: UITableViewController {
    
    //MARK: naming
    
    weak var delegate: MainViewControllerDelegate?
    private var presenter = MainViewPresenter()
    private lazy var networkManager = NetworkManager.shared
    
    private var popularMovies: [Movie] { presenter.popularMovies }
    private lazy var movies: [Movie] = popularMovies
    
    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = presenter
        setupView()
    }
    
    //MARK: - Methods
    
    private func setupView() {
        tableView.backgroundColor = .green
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.register(SearchHeaderView.self, forHeaderFooterViewReuseIdentifier: SearchHeaderView.identifier)
        tableView.allowsSelection = false
    }
    
    private func updateWithPopularMovies() {
        movies = popularMovies
        tableView.reloadData()
    }
    
    func searchMovies(with query: String) async -> [Movie] {
        guard let foundMovies = await delegate?.searchMovies(with: query) else { return [] }
        return foundMovies
    }
}

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SearchHeaderView()
        header.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
}

extension MainViewController: SearchHeaderViewDelegate {
    
    func search(_ query: String) {
        
        guard !query.isEmpty/*, let foundMovies = await mainTableViewDelegate?.searchMovies(with: query) */else {
            updateWithPopularMovies()
            return
        }
        
        //        movies = foundMovies
        //        reloadData()
        
        search(withClosure: true, with: query)
    }
    
    
    // TBD
    
    func search(withClosure: Bool, with query: String ) {
        
        guard withClosure else {
            Task {
                let movies = try await NetworkManager.shared.searchMovies(query: query)
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
}


    


