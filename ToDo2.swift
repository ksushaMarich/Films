//
//  RespondView.swift
//  Films
//
//  Created by Ксения Маричева on 29.11.2024.
//




    
    
    // Повторить и понять этот код
    
//    func updateWithClosure(with query: String) {
//        
//        guard !query.isEmpty else {
//            updateWithPo pularMovies()
//            return
//        }
//        
//        networkManager.searchMoviesWithClosure(for: query) { result in
//            switch result {
//            case .success(let movies):
//                self.movies = movies
//                self.reloadData()
//            case .failure(let error):
//                print("Ошибка: \(error.localizedDescription)")
//                self.updateWithPo pularMovies()
//            }
//        }
//    }
    
    
    // Повторить и понять этот код
    
    /*searchMoviesWithClosure(for: query) { movies in
        self.movies = movies
        self.reloadData()
    }
    
    func searchMoviesWithClosure(for query: String, success: @escaping ([Movie]) -> Void) {
        networkManager.searchMoviesWithClosure(for: query) { result in
            switch result {
            case .success(let movies):
                success(movies)
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
                self.updateWithPop ularMovies()
            }
        }
    }
    
    searchMoviesWithClosure(for: query) { movies in
        self.movies = movies
        self.reloadData()
    } failure: {
        self.updateWithPopular Movies()
    }
    
    func searchMoviesWithClosure(for query: String, success: @escaping ([Movie]) -> Void, failure: @escaping () -> Void) {
        networkManager.searchMoviesWithClosure(for: query) { result in
            switch result {
            case .success(let movies):
                success(movies)
            case .failure(let error):
                print("Ошибка: \(error.localizedDescription)")
                failure()
            }
        }
    }*/


