//
//  NM.swift
//  Films
//
//  Created by Ксения Маричева on 12.01.2025.
//

import UIKit

class NM {
    private static let networkManager = NetworkManager.shared
    
    static func searchMovies(query: String? = nil, success: @escaping ([Movie]) -> Void, failure: @escaping (String) -> Void) {
        Task {
            do {
                let movies = try await networkManager.searchMovies(query: query)
                
                DispatchQueue.main.async {
                    success(movies)
                }
                
            } catch let error as APIError {
                DispatchQueue.main.async {
                    failure(error.description)
                }
            }
        }
    }
    
    #warning("Новая функция не дал оставить [weak self]")
    static func searchMoviesWithClosure(query: String, success: @escaping ([Movie]) -> Void, failure: @escaping (String) -> Void) {
        networkManager.searchMoviesWithClosure(for: query) { result in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    success(movies)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    failure(error.description)
                }
            }
        }
    }
    #warning("Новая функция")
    static func downloadPoster(posterPath: String?, success: @escaping (UIImage) -> Void, failure: @escaping (String) -> Void) {
        Task {
            do {
                let poster = try await NetworkManager.shared.downloadPoster(poster: posterPath)
                
                DispatchQueue.main.async {
                    success(poster)
                }
                
            } catch let error as APIError {
                DispatchQueue.main.async {
                    failure(error.description)
                }
            }
        }
    }
    
    #warning("Новая функция")
    static func getDetails(by movieId: Int, success: @escaping (MovieDetails) -> Void, failure: @escaping (String) -> Void) {
        Task {
            do {
                let movieDetails = try await networkManager.downloadMovieDetails(for: movieId)
                DispatchQueue.main.async {
                    success(movieDetails)
                }
                
            } catch let error as APIError {
                DispatchQueue.main.async {
                    failure(error.description)
                }
            }
        }
    }
}

