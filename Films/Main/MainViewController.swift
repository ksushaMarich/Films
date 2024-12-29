//
//  ViewController.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

#warning("Изменила название делегата")
protocol OutputMainViewControllerDelegate: AnyObject {
    func searchMovies(with query: String)
#warning("Новое")
    func didSelectMovie(_ movie: Movie)
}

class MainViewController: UITableViewController {
    
    //MARK: naming
    
    weak var delegate: OutputMainViewControllerDelegate?
    private var presenter = MainViewPresenter()
    private lazy var networkManager = NetworkManager.shared
    
    private lazy var movies: [Movie] = presenter.popularMovies
    
    //MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        delegate = presenter
        setupView()
    }
    
    //MARK: - Methods
    
    private func setupView() {
        tableView.backgroundColor = .green
//        tableView.contentInsetAdjustmentBehavior = .never
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
    
//    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        70
//    }
    
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

#warning("Новое")
extension MainViewController: MovieCellDelegate {
    func didSelectMovie(_ movie: Movie) {
        delegate?.didSelectMovie(movie)
    }
}

extension MainViewController: SearchHeaderViewDelegate {
    func search(_ query: String) {
#warning("Теперь контроллер только нежно просит делигат сделать все")
        delegate?.searchMovies(with: query)
    }
}

extension MainViewController: InputMainViewControllerDelegate {
    
#warning("Новое")
    func update(with movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
            self.tableView.reloadData()
        }
    }
    
#warning("Новое")
    func presentMovieDetails(with controller: MovieDetailsController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

    


