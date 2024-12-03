//
//  RespondViewController.swift
//  Films
//
//  Created by Ксения Маричева on 29.11.2024.
//

import UIKit

class RespondViewController: UIViewController {
    
    //MARK: - naming
    let movies: [Movie]
    
    private lazy var respondTableView: RespondTableView = {
        let tableView = respondTableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: - init
    init(movies: [Movie]) {
        self.movies = movies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        for movie in movies {
            print(movie.title)
        }
    }
    
    //MARK: - setup view methods
}
