//
//  NetworkManager.swift
//  Films
//
//  Created by Ксюша on 29.11.2024.
//

import UIKit

class NetworkManager {
    
    //интерфейса пользователя (UI), который учитывает использование данных. View получает команды от Presenter и отображает данные, но ничего не знает о бизнес-логике.
    
    static let shared = NetworkManager()
    
    private let apiKey = "5e491b5e3a7e7c82df6c07d1c7448db1"
    private let baseURL = "https://api.themoviedb.org/3"
    private let language = "ru-RU"
    
    private init() {}
            
    private func formURL(query: String?) -> URL? {
        
        var urlComponents = URLComponents()
        
        var queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: language)]
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        
        urlComponents.path = "/3/movie/popular"
        
        if let query = query {
            urlComponents.path = "/3/search/movie"
            queryItems += [URLQueryItem(name: "query", value: query)]
        }
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
    
    func searchMovies(query: String? = nil) async throws -> [Movie] {
        
        guard let url = formURL(query: query) else { throw APIError.invalidURL }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return (try JSONDecoder().decode(MovieResponse.self, from: data)).results
        } catch { print(error) }
        
        return []
    }
    
    func searchMoviesWithClosure(for query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = formURL(query: query) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(APIError.noData))
                return
            }
            
            do {
                let results = (try JSONDecoder().decode(MovieResponse.self, from: data)).results
                completion(.success(results))
            } catch  {
                completion(.failure(error))
            }
            
        }.resume()
    }
#warning("заменила (for movie: Movie) на (poster: String?)")
    func downloadPoster(poster: String?) async throws -> UIImage {
        
        let posterImage = UIImage(named: "PosterError")!
        
        guard let poster, let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)") else {
            return posterImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return UIImage(data: data) ?? posterImage
    }
    
#warning("new")
    func downloadMovieDitails(for movieId: Int) async throws -> MovieDetails {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(String(movieId))?api_key=5e491b5e3a7e7c82df6c07d1c7448db1&language=ru-RU") else {
            throw APIError.invalidURL
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let x = try JSONDecoder().decode(MovieDetails.self, from: data)
            return x
        } catch { throw error}
    }
}
