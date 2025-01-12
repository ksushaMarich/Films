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
        
        if let query {
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
        } catch { throw APIError.noData }
        
        return []
    }
    
    
    #warning("добавила типы выкидываемых ошибок")
    func searchMoviesWithClosure(for query: String, completion: @escaping (Result<[Movie],
                                                                           APIError>) -> Void) {
        
        guard let url = formURL(query: query) else {
            completion(.failure(APIError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let error {
                    completion(.failure(APIError.serverError))
                    return
                }
                
                guard let data else {
                    completion(.failure(APIError.noData))
                    return
                }
                
                do {
                    completion(.success((try JSONDecoder().decode(MovieResponse.self, from: data)).results))
                } catch  {
                    completion(.failure(APIError.decodingError))
                }
            }
            
        }.resume()
    }
    
    func downloadPoster(poster: String?) async throws -> UIImage {
        
        let posterImage = UIImage(named: "PosterError")!
        
        guard let poster, let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)") else { return posterImage }
        
    #warning("добавила do catch")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data) ?? posterImage
        } catch { throw APIError.noData }
    }
    
    func downloadMovieDetails(for movieId: Int) async throws -> MovieDetails {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(String(movieId))?api_key=5e491b5e3a7e7c82df6c07d1c7448db1&language=ru-RU")
        else { throw APIError.invalidURL }
        
    #warning("добавила do catch")
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(MovieDetails.self, from: data)
        } catch { throw APIError.noData }
    }
}
