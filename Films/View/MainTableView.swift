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
    weak var viewDataSource: MainTableViewDataSource?
    
    private lazy var networkManager = NetworkManager.shared
    
    private var movies: [Movie]
    
    //MARK: - init
    init(movies: [Movie]) {
        self.movies = movies
        super.init(frame: .zero, style: UITableView.Style.plain)
        backgroundColor = .yellow
        delegate = self
        dataSource = self
        register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        register(FilmViewCell.self, forCellReuseIdentifier: FilmViewCell.identifier)
        allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupView methods
    
}

extension MainTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard indexPath.row == 0 else {
            guard let cell = dequeueReusableCell(withIdentifier: FilmViewCell.identifier, for: indexPath) as? FilmViewCell else { return UITableViewCell() }
            cell.configuring(movie: movies[indexPath.row - 1])
            return cell
        }
        guard let cell = dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.cellDelegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { movies.count + 1 }
}

extension MainTableView: SearchCellDelegate {
    func update(with query: String) {
        
        guard query != "" else {
            guard let movies = viewDataSource?.movies else { return }
            self.movies = movies
            reloadData()
            return
        }
        Task {
            let movies = try await NetworkManager.shared.searchMoviesFromQuery(query: query)
            self.movies = movies
            reloadData()
        }
    }
}

