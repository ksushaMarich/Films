//
//  ViewController.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - naming
    private let popularMovies: [Movie]
    
    private lazy var mainView: MainTableView = {
        let view = MainTableView(movies: popularMovies)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.viewDataSource = self
        return view
    }()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - init
    
    init(popularMovies: [Movie]) {
        self.popularMovies = popularMovies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupViewMethods
    
    private func setupView() {
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension MainViewController: MainTableViewDataSource {
    var movies: [Movie] { popularMovies }
}

