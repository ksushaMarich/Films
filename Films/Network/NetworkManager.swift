//
//  NetworkManager.swift
//  Films
//
//  Created by Ксюша on 29.11.2024.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let apiKey = "5e491b5e3a7e7c82df6c07d1c7448db1"
    private let baseURL = "https://api.themoviedb.org/3"
    private let language = "ru-RU"
    
    private init() {}
    
    func searchPopularMovies() async throws -> [Movie] {
//        https://api.themoviedb.org/3/movie/popular?api_key=ВАШ_API_КЛЮЧ
//        let path = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\("Убить Билла")&language=\(language)"
        
        let path = "\(baseURL)/movie/popular?api_key=\(apiKey)&language=\(language)"
        
        guard let url = URL(string: path) else { throw APIError.invalidURL }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return (try JSONDecoder().decode(MovieResponse.self, from: data)).results
        } catch { print(error) }
        
        return []
    }

    func searchMoviesFromQuery(query: String) async throws -> [Movie] {
        
        let path = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(query)&language=\(language)"
        
        guard let url = URL(string: path) else { throw APIError.invalidURL }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return (try JSONDecoder().decode(MovieResponse.self, from: data)).results
        } catch { print(error) }
        
        return []
    }
    
    func downloadPoster(from movie: Movie) async throws -> UIImage {
        var posterImage = UIImage(named: "PosterError")!
        
        guard let poster = movie.poster, let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)") else {
            return posterImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let image = UIImage(data: data)
        guard let image else {
            return posterImage
        }
        posterImage = image
        return posterImage
    }
}
