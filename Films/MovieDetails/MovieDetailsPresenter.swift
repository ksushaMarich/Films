//
//  MovieDetailsPresenter.swift
//  Films
//
//  Created by Ксения Маричева on 26.12.2024.
//

import UIKit

protocol MovieDetailsInput: AnyObject {
    var presenter: MovieDetailsOutput? { get set }
    func configure(with movieDetails: MovieDetails)
}

protocol MovieDetailsOutput: AnyObject {
    var view: MovieDetailsInput? { get set }
    func getDetails(by movieId: Int)
}

class MovieDetailsPresenter: MovieDetailsOutput {
    
    // MARK: - naming
    weak var view: MovieDetailsInput?
    
    // MARK: - methods
    func getDetails(by movieId: Int) {
        Task {
            let movieDetails = try await NetworkManager.shared.downloadMovieDetails(for: movieId)
            DispatchQueue.main.async {
                self.view?.configure(with: movieDetails)
            }
        }
    }
}
