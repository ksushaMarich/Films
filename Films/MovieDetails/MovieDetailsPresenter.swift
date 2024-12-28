//
//  MovieDetailsPresenter.swift
//  Films
//
//  Created by Ксения Маричева on 26.12.2024.
//

import Foundation

#warning("Новое")

protocol OutputMovieDetailsViewDelegate: AnyObject {
    func configure(with movieDetails: MovieDetails)
}

class MovieDetailsPresenter {
    
    // MARK: - naming
    weak var delegate: OutputMovieDetailsViewDelegate?
    
    // MARK: - methods
    func giveData(movieId: Int) {
        Task {
            delegate?.configure(with: try await NetworkManager.shared.downloadMovieDitails(for: movieId))
        }
    }
}
