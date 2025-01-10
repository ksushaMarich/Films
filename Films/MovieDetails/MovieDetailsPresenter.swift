//
//  MovieDetailsPresenter.swift
//  Films
//
//  Created by Ксения Маричева on 26.12.2024.
//

import UIKit

#warning("добавила новую функцию в протокол")
protocol MovieDetailsInput: AnyObject {
    var presenter: MovieDetailsOutput? { get set }
    func configureWithDetails(_ movieDetails: MovieDetails)
    func configureWithPoster(_ poster: UIImage)
}

protocol MovieDetailsOutput: AnyObject {
    var view: MovieDetailsInput? { get set }
    func getDetails(by movieId: Int)
}

class MovieDetailsPresenter: MovieDetailsOutput {
    
    // MARK: - naming
    weak var view: MovieDetailsInput?
    
    // MARK: - methods
    #warning("изменила функцию что бы постер качался тут а не в контроллере")
    func getDetails(by movieId: Int) {
        Task {
            let movieDetails = try await NetworkManager.shared.downloadMovieDetails(for: movieId)
            DispatchQueue.main.async {
                self.view?.configureWithDetails(movieDetails)
            }
            let poster = try await NetworkManager.shared.downloadPoster(poster: movieDetails.poster)
            DispatchQueue.main.async {
                self.view?.configureWithPoster(poster)
            }
        }
    }
}
