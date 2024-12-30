//
//  ViewController.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

class MainViewController: UITableViewController {
    
    // MARK: naming
    
    var presenter: MainViewOutput?
    private lazy var movies: [Movie] = []
    
    // MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupView() {
        tableView.backgroundColor = .green
        //tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.register(SearchHeaderView.self, forHeaderFooterViewReuseIdentifier: SearchHeaderView.identifier)
        tableView.allowsSelection = false
    }
}

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SearchHeaderView()
        header.delegate = self
        return header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
}

extension MainViewController: MainViewInput {
    func update(with movies: [Movie]) {
        self.movies = movies
        tableView.reloadData()
    }
}

extension MainViewController: MovieCellDelegate {
    func didSelectMovie(_ movie: Movie) {
        navigationController?.pushViewController(MovieDetailsController(id: movie.id), animated: true)
    }
}

extension MainViewController: SearchHeaderViewDelegate {
    func search(_ query: String) {
        presenter?.searchMovies(with: query)
    }
}



    


