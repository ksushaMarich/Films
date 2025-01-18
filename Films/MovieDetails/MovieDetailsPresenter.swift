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
    #warning("Поменяла метод что бы работал через обращение к NM")
    func getDetails(by movieId: Int) {
        var gottenDetails: MovieDetails?
        
        #warning("Добавила weak self, что бы предотватить утечку памяти")
        NM.getDetails(by: movieId) { [weak self] movieDetails in
            self?.view?.configureWithDetails(movieDetails)
            gottenDetails = movieDetails
            
            NM.downloadPoster(posterPath: gottenDetails?.poster) { [ weak self] poster in
                self?.view?.configureWithPoster(poster)
                
            } failure: { error in
                print(error)
            }
            
        } failure: { error in
            print(error)
        }
    }
}
