//
//  Presenter.swift
//  Films
//
//  Created by Ксения Маричева on 20.12.2024.
//

import Foundation

let viaClosure = true

protocol MainViewInput: AnyObject {
    var presenter: MainViewOutput? { get set }
    func update(with movies: [Movie])
    func showAlert(with title: String)
}

protocol MainViewOutput: AnyObject {
    var view: MainViewInput? { get set }
    func searchMovies(with query: String)
}

class MainViewPresenter {
    
    weak var view: MainViewInput?
    private let networkManager = NetworkManager.shared
    
    private lazy var popularMovies: [Movie] = []
    
    init() {
        NM.searchMovies { popularMovies in
            self.popularMovies = popularMovies
            self.view?.update(with: popularMovies)
        } failure: { error in
            self.view?.showAlert(with: error)
        }
    }
}

extension MainViewPresenter: MainViewOutput {
    
    func searchMovies(with query: String) {
        query.isEmpty ? view?.update(with: popularMovies) :
        viaClosure ? searchWithClosure(with: query) : search(with: query)
    }
    
    func search(with query: String) {
        NM.searchMovies(query: query) { movies in
            self.view?.update(with: movies)
        } failure: { error in
            self.view?.showAlert(with: error)
        }
    }
    
    func searchWithClosure(with query: String) {
        
        networkManager.searchMoviesWithClosure(for: query) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movies):
                view?.update(with: movies)
            case .failure(let error):
                view?.showAlert(with: error.description)
            }
        }
    }
}
