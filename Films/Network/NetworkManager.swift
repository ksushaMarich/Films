//
//  NetworkManager.swift
//  Films
//
//  Created by Ксюша on 29.11.2024.
//

import UIKit

struct MovieResponse: Codable{
    let results: [Movie]
}

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    private let apiKey = "5e491b5e3a7e7c82df6c07d1c7448db1"
    private let baseURL = "https://api.themoviedb.org/3"
    private let language = "ru-RU"
    private var response: MovieResponse?
    var error: String?
    
    var movies: [Movie] = []
    var posters: [UIImage?] = []
    
    private init() {}

    func searchMovies(query: String) {
        let urlString = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&language=\(language)"
        
        guard let url = URL(string: urlString) else {
            self.error = "url is not found"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.error = "Ошибка  \(error.localizedDescription)"
                return
            }
            
            guard let data = data else {
                self.error = "Нет данных"
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                self.response = response
                var movies: [Movie] = []
                for movie in response.results {
                    movies.append(movie)
                }
                self.movies = movies
                
            } catch {
                self.error = "Ошибка парсинга"
                return
            }
        }.resume()
    }
    
    func downloadPosters() {
        var posters: [UIImage?] = []
        
        for movie in movies {
            guard let url = movie.posterURL else {
                self.error = "url is not found"
                return
            }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    self.error = " Ошибка загрузки изображения: \(error.localizedDescription)"
                    posters.append(nil)
                    return
                }
                guard let data = data, let image = UIImage(data: data) else { return }
                posters.append(image)
            }
        }
        self.posters = posters
    }
}
