//
//  MovieDetailsPresenter.swift
//  Films
//
//  Created by Ксения Маричева on 26.12.2024.
//

import Foundation

#warning("Новое")

protocol OutputMovieDetailsViewDelegate: AnyObject {
    func configure(_ movieDetails: MovieDetails)
}

class MovieDetailsPresenter {
    
    // MARK: - naming
    weak var delegate: OutputMovieDetailsViewDelegate?
    
    // MARK: - methods
    func giveData(movieId: Int) {
        Task {
            let movieDetails = try await NetworkManager.shared.downloadMovieDitails(for: movieId)
            delegate?.configure(movieDetails)
        }
    }
}
