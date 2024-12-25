//
//  Presenter.swift
//  Films
//
//  Created by Ксения Маричева on 20.12.2024.
//

import Foundation

#warning("Добавила новую связь")
protocol InputMainViewControllerDelegate: AnyObject {
    func update(with movies: [Movie])
}

class MainViewPresenter {
    weak var delegate: InputMainViewControllerDelegate?
    
    private let networkManager = NetworkManager.shared
    
#warning("Новое")
    lazy var popularMovies: [Movie] = networkManager.popularMovies
    private lazy var movies: [Movie] = []
}

extension MainViewPresenter: OutputMainViewControllerDelegate {
    func searchMovies(with query: String) {
            
            guard !query.isEmpty else {
#warning("Новое")
                delegate?.update(with: popularMovies)
                return
            }
            
            search(withClosure: true, with: query)
        
        
        
        // TBD
        
        func search(withClosure: Bool, with query: String ) {
            guard withClosure else {
                Task {
                    let movies = try await NetworkManager.shared.searchMovies(query: query)
                    self.movies = movies
#warning("Новое")
                    delegate?.update(with: movies)
                }
                return
            }
            
            networkManager.searchMoviesWithClosure(for: query) { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
#warning("Новое")
                    self.delegate?.update(with: self.movies)
                case .failure(let error):
                    print("Ошибка: \(error.localizedDescription)")
#warning("Новое")
                    self.delegate?.update(with: self.popularMovies)
                }
            }
        }
    }
}
