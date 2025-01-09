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
    
    private var currentRequest: String = ""
    
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
    #warning("Новая функция срабатывает, когда пустой запрос")
    func searchBarIsEmpty() {
        view?.update(with: popularMovies)
        currentRequest = ""
    }
    
    
    func searchMovies(with query: String) {
            
            guard !query.isEmpty else { return }
            
        viaClosure ? searchWithClosure(with: query) : search(with: query)
    }
    
    func search(with query: String) {
    #warning("добавила проверку и присвоение значения переменной")
        guard currentRequest != query else { return }
        
        currentRequest = query
        
        Task {
            let movies = try await NetworkManager.shared.searchMovies(query: query) // do-catch
            
            DispatchQueue.main.async {
                self.view?.update(with: movies)
            }
        }
    }
    
    func searchWithClosure(with query: String) {
    #warning("добавила проверку и присвоение значения переменной")
        guard currentRequest != query else { return }
        
        currentRequest = query
        
        networkManager.searchMoviesWithClosure(for: query) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let movies):
                view?.update(with: movies)
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
                view?.update(with: popularMovies)
            }
        }
    }
}
