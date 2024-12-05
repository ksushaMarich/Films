//
//  RespondView.swift
//  Films
//
//  Created by Ксения Маричева on 29.11.2024.
//

import UIKit

class FilmsViewTableView: UITableView {

    //MARK: - naming
    private lazy var networkManager = NetworkManager.shared
    
    private lazy var movies = networkManager.movies
    private lazy var posterders = networkManager.posters
    
    //MARK: - init
    init() {
        super.init(frame: .zero, style: UITableView.Style.plain)
        backgroundColor = .yellow
        delegate = self
        dataSource = self
//        separatorColor = .clear
        register(FilmViewCell.self, forCellReuseIdentifier: FilmViewCell.identifier)
        allowsSelection = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupView methods
}

extension FilmsViewTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: FilmViewCell.identifier, for: indexPath) as? FilmViewCell else { return UITableViewCell() }
        cell.configuring(movie: movies[indexPath.row], poster: posterders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { movies.count }
}

