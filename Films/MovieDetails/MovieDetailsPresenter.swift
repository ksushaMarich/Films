//
//  MovieDetailsPresenter.swift
//  Films
//
//  Created by Ксения Маричева on 26.12.2024.
//

import UIKit

#warning("Сделала такую же связь как делали на занятии")

protocol MovieDetailsInput: AnyObject {
    var presenter: MovieDetailsOutput? { get set }
    func configure(with movieDetails: MovieDetails)
}

protocol MovieDetailsOutput: AnyObject {
    var view: MovieDetailsInput? { get set }
    func giveData(movieId: Int?)
}

class MovieDetailsPresenter: MovieDetailsOutput {
    
    // MARK: - naming
    weak var view: MovieDetailsInput?
    
    // MARK: - methods
    func giveData(movieId: Int?) {
        guard let movieId else { return }
        Task {
            view?.configure(with: try await NetworkManager.shared.downloadMovieDitails(for: movieId))
        }
    }
}
