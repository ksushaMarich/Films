//
//  Presenter.swift
//  Films
//
//  Created by Ксения Маричева on 20.12.2024.
//

import Foundation

protocol InputMainViewControllerDelegate: AnyObject {
    func update(with movies: [Movie])
}

class MainViewPresenter {
    weak var delegate: InputMainViewControllerDelegate?
    
    private let networkManager = NetworkManager.shared
    
    lazy var popularMovies: [Movie] = networkManager.popularMovies
    private lazy var movies: [Movie] = []
}

extension MainViewPresenter: OutputMainViewControllerDelegate {
    func searchMovies(with query: String) {
            
            guard !query.isEmpty else {
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
                    delegate?.update(with: movies)
                }
                return
            }
            
            networkManager.searchMoviesWithClosure(for: query) { result in
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.delegate?.update(with: self.movies)
                case .failure(let error):
                    print("Ошибка: \(error.localizedDescription)")
                    self.delegate?.update(with: self.popularMovies)
                }
            }
        }
    }
}
