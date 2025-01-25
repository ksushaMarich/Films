//
//  MovieDetailsPresenter.swift
//  Films
//
//  Created by Ксения Маричева on 26.12.2024.
//

import UIKit

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
    
    func getDetails(by movieId: Int) {
        NM.getDetails(by: movieId) { [weak self] movieDetails in
            self?.view?.configureWithDetails(movieDetails)
        } failure: { error in
            print(error)
        }
    }
}
