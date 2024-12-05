//
//  RespondView.swift
//  Films
//
//  Created by Ксения Маричева on 29.11.2024.
//

import UIKit

class FilmsViewTableView: UITableView {

    //MARK: - naming
    let movies: [Movie]
    
    //MARK: - init
    init(movies: [Movie]) {
        self.movies = movies
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
        cell.configuring(movie: movies[indexPath.row], poster: postorders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { movies.count }
}

