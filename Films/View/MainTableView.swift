//
//  RespondView.swift
//  Films
//
//  Created by Ксения Маричева on 29.11.2024.
//

import UIKit

protocol MainTableViewDataSource: AnyObject {
    var movies: [Movie] { get }
}

class MainTableView: UITableView {

    //MARK: - naming
    weak var moviesDataSource: MainTableViewDataSource?
    
    private lazy var networkManager = NetworkManager.shared
    
    private var movies: [Movie]
    
    //MARK: - init
    init(movies: [Movie]) {
        self.movies = movies
        super.init(frame: .zero, style: UITableView.Style.plain)
        backgroundColor = .green
        delegate = self
        dataSource = self
        register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - reloadData methods
    private func updateWithPopularMovies() {
        guard let movies = self.moviesDataSource?.movies else { return }
        self.movies = movies
        self.reloadData()
    }
}

extension MainTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderTableView()
        header.delegate = self
        return section == 0 ? header : nil
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 10 : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        cell.configure(with: movies[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { movies.count}
}

extension MainTableView: HeaderTableViewDelegate {
    
    func search(withClosure: Bool, with query: String ) {
        guard withClosure else {
            Task {
                let movies = try await NetworkManager.shared.searchMovies(query: query)
                self.movies = movies
                reloadData()
            }
            return
        }
        networkManager.searchMoviesWithClosure(for: query) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.reloadData()
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
                self.updateWithPopularMovies()
            }
        }
    }
    
    func update(with query: String) {
        
        guard !query.isEmpty else {
            updateWithPopularMovies()
            return
        }
        
        search(withClosure: true, with: query)
    }
    
    
    // Повторить и понять этот код
    
//    func updateWithClosure(with query: String) {
//        
//        guard !query.isEmpty else {
//            updateWithPopularMovies()
//            return
//        }
//        
//        networkManager.searchMoviesWithClosure(for: query) { result in
//            switch result {
//            case .success(let movies):
//                self.movies = movies
//                self.reloadData()
//            case .failure(let error):
//                print("Ошибка: \(error.localizedDescription)")
//                self.updateWithPopularMovies()
//            }
//        }
//    }
    
    
    // Повторить и понять этот код
    
    /*searchMoviesWithClosure(for: query) { movies in
        self.movies = movies
        self.reloadData()
    }
    
    func searchMoviesWithClosure(for query: String, success: @escaping ([Movie]) -> Void) {
        networkManager.searchMoviesWithClosure(for: query) { result in
            switch result {
            case .success(let movies):
                success(movies)
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
                self.updateWithPopularMovies()
            }
        }
    }
    
    searchMoviesWithClosure(for: query) { movies in
        self.movies = movies
        self.reloadData()
    } failure: {
        self.updateWithPopularMovies()
    }
    
    func searchMoviesWithClosure(for query: String, success: @escaping ([Movie]) -> Void, failure: @escaping () -> Void) {
        networkManager.searchMoviesWithClosure(for: query) { result in
            switch result {
            case .success(let movies):
                success(movies)
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
                failure()
            }
        }
    }*/
}

