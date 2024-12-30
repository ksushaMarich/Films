//
//  Presenter.swift
//  Films
//
//  Created by Ксения Маричева on 20.12.2024.
//

import Foundation

let viaClosure = true

class MainViewPresenter {
    
    weak var view: MainViewInput?
    private let networkManager = NetworkManager.shared
    
    private lazy var popularMovies: [Movie] = []
    private lazy var movies: [Movie] = []
    
    init() {
        Task {
            popularMovies = try await networkManager.searchMovies() // do-catch
            
            DispatchQueue.main.async {
                self.view?.update(with: self.popularMovies)
            }
        }
    }
}

extension MainViewPresenter: MainViewOutput {
    
    func searchMovies(with query: String) {
            
            guard !query.isEmpty else {
                view?.update(with: popularMovies)
                return
            }
            
        viaClosure ? searchWithClosure(with: query) : search(with: query)
    }
    
    func search(with query: String) {
        Task {
            movies = try await NetworkManager.shared.searchMovies(query: query) // do-catch
            
            DispatchQueue.main.async {
                self.view?.update(with: self.movies)
            }
        }
    }
    
    func searchWithClosure(with query: String) {
        
        networkManager.searchMoviesWithClosure(for: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    #warning("Новое")
                    self.view?.update(with: self.movies)
                case .failure(let error):
                    print("Ошибка: \(error.localizedDescription)")
                    #warning("Новое")
                    self.view?.update(with: self.popularMovies)
                }
            }
        }
    }
}
