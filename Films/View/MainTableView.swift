//
//  RespondView.swift
//  Films
//
//  Created by Ксения Маричева on 29.11.2024.
//

import UIKit

protocol MainTableViewDelegate: AnyObject {
    func updateTableView(with movies: [Movie])
}

class MainTableView: UITableView {

    //MARK: - naming
    weak var viewDelegate: MainTableViewDelegate?
    
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
    func update(with movies: [Movie]) {
        self.movies = movies
        reloadData()
    }
}

