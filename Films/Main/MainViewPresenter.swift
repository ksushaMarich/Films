//
//  Presenter.swift
//  Films
//
//  Created by Ксения Маричева on 20.12.2024.
//

import UIKit

let viaClosure = true

protocol MainViewInput: AnyObject {
    var presenter: MainViewOutput? { get set }
    func update(with movies: [Movie])
    func showAlert(with title: String)
    func configureCellWithPoster(_ poster: UIImage, at indexPath: IndexPath)
}

protocol MainViewOutput: AnyObject {
    var view: MainViewInput? { get set }
    func searchMovies(with query: String)
    func getPoster(for movie: Movie, at indexPath: IndexPath)
}

class MainViewPresenter {
    
    weak var view: MainViewInput?
    
    private lazy var popularMovies: [Movie] = []
    
    lazy var successClosure: ([Movie]) -> Void = { [weak self] movies in
        self?.view?.update(with: movies)
    }
    
    lazy var failureClosure: (String) -> Void = { [weak self] error in
        self?.view?.showAlert(with: error)
    }
    
    init() {
        searchPopularMovies()
    }
    
    private func searchPopularMovies() {
        NM.searchMovies(success: { [weak self] popularMovies in
            self?.popularMovies = popularMovies
            self?.view?.update(with: popularMovies)
        }, failure: failureClosure)
    }
}

extension MainViewPresenter: MainViewOutput {
    
    func searchMovies(with query: String) {
        
        let isEmpty = query.isEmpty || query.rangeOfCharacter(from: .whitespacesAndNewlines.inverted) == nil
        
        isEmpty ? view?.update(with: popularMovies) :
        viaClosure ? searchWithClosure(with: query) : search(with: query)
    }
    
    func search(with query: String) {
        NM.searchMovies(query: query, success: successClosure, failure: failureClosure)
    }
    
    func searchWithClosure(with query: String) {
        NM.searchMoviesWithClosure(query: query, success: successClosure, failure: failureClosure)
    }

    func getPoster(for movie: Movie, at indexPath: IndexPath) {
        NM.downloadPoster(posterPath: movie.poster, success: { [weak self] poster in
            self?.view?.configureCellWithPoster(poster, at: indexPath)
        }, failure: failureClosure)
    }
}
