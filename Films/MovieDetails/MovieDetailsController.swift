//
//  MovieDetailsController.swift
//  Films
//
//  Created by Ксения Маричева on 26.12.2024.
//

import UIKit

class MovieDetailsController: UIViewController {
    
    // MARK: - naming
    private let presenter = MovieDetailsPresenter()
    private let id: Int
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - init
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - methods
    private func setupView() {
        presenter.delegate = self
        presenter.giveData(movieId: id)
        view.backgroundColor = .red
        view.addSubview(overviewLabel)
        
        NSLayoutConstraint.activate([
            overviewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            overviewLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        ])
    }
}

extension MovieDetailsController: OutputMovieDetailsViewDelegate {
    func configure(_ movieDetails: MovieDetails) {
        overviewLabel.text = movieDetails.overview
    }
}
