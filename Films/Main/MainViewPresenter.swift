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
    func configCellWithPoster(with poster: UIImage, at indexPath: IndexPath)
}

protocol MainViewOutput: AnyObject {
    var view: MainViewInput? { get set }
    func searchMovies(with query: String)
    func getPoster(at indexPath: IndexPath, for movie: Movie)
}

class MainViewPresenter {
    
    weak var view: MainViewInput?
    
    private lazy var popularMovies: [Movie] = []
    
    #warning("Добавила weak self, что бы предотватить утечку памяти")
    init() {
        NM.searchMovies { [weak self] popularMovies in
            self?.popularMovies = popularMovies
            self?.view?.update(with: popularMovies)
        } failure: { [weak self] error in
            self?.view?.showAlert(with: error)
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
    
    #warning("Поменяла функцию теперь она обращается к NM")
    func searchWithClosure(with query: String) {
        NM.searchMoviesWithClosure(query: query, success: { movies in
            self.view?.update(with: movies)
        }) { error in
            self.view?.showAlert(with: error)
        }
    }

    func getPoster(at indexPath: IndexPath, for movie: Movie) {
        #warning("Пыталась востановить метод который делали на занятии")
        NM.downloadPoster(posterPath: movie.poster) { [weak self] poster in
            self?.view?.configCellWithPoster(with: poster, at: indexPath)
        } failure: { error in
            print(error)
        }

    }
}
