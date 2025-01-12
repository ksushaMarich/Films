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
    #warning("добавила новую функцию")
    func showAlert(with title: String)
}

protocol MainViewOutput: AnyObject {
    var view: MainViewInput? { get set }
    func searchMovies(with query: String)
    func searchBarIsEmpty()
}

class MainViewPresenter {
    
    weak var view: MainViewInput?
    private let networkManager = NetworkManager.shared
    
    private lazy var popularMovies: [Movie] = []
    
    init() {
        Task {
        #warning("добавила блок do catch")
            do {
            popularMovies = try await networkManager.searchMovies()
            
                DispatchQueue.main.async {
                    self.view?.update(with: self.popularMovies) }
                
            } catch let error as APIError { view?.showAlert(with: error.description) }
        }
    }
}

extension MainViewPresenter: MainViewOutput {
    #warning("Новая функция срабатывает, когда пустой запрос")
    func searchBarIsEmpty() {
        view?.update(with: popularMovies)
    }
    
    
    func searchMovies(with query: String) {
            
            guard !query.isEmpty else { return }
            
        viaClosure ? searchWithClosure(with: query) : search(with: query)
    }
    
    func search(with query: String) {
        #warning("добавила блок do catch")
        Task {
            do {
                let movies = try await NetworkManager.shared.searchMovies(query: query)
                
                DispatchQueue.main.async {
                    self.view?.update(with: movies)
                }
            } catch let error as APIError { view?.showAlert(with: error.description) }
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
