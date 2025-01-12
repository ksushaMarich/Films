//
//  ViewController.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: naming
    var presenter: MainViewOutput?
    private lazy var movies: [Movie] = []
 
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.sectionHeaderTopPadding = 0
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        tableView.register(SearchHeaderView.self, forHeaderFooterViewReuseIdentifier: SearchHeaderView.identifier)
        tableView.separatorColor = .gray
        tableView.backgroundColor = .black
        return tableView
    }()
    
    // MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SearchHeaderView()
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        
        cell.isUserInteractionEnabled = true
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
    
    #warning("сделала распознование нажатия в ячейки стандартым а не через делегат")
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ViewBuilder.build(type: .movieDetails(id: movies[indexPath.row].id)), animated: true)
    }
}

extension MainViewController: MainViewInput {
    
    func update(with movies: [Movie]) {
        self.movies = movies
        #warning("Добавила прокрутку на верх при поиске фильмов")
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        tableView.reloadData()
    }
    
    #warning("добавила отображение алерта в случаях возникновения ошибки")
    func showAlert(with title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: SearchHeaderViewDelegate {
    
    func search(_ query: String) {
        presenter?.searchMovies(with: query)
    }
    
    func searchBarIsEmpty() {
        presenter?.searchBarIsEmpty()
    }
}


    


