//
//  NetworkManager.swift
//  Films
//
//  Created by Ксюша on 29.11.2024.
//

import Foundation

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
    private var response: MovieResponse?
    let language = "ru-RU" // Устанавливаем язык

    private init() {}

    func searchMovies(query: String) {
        let urlString = "\(baseURL)/search/movie?api_key=\(apiKey)&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&language=\(language)"
        
        guard let url = URL(string: urlString) else {
            print("url is not found")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка  \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Нет данных")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                self.response = response
                for movie in response.results {
                    print(movie.title)
                }
                
            } catch {
                print("Ошибка парсинга")
            }
        }.resume()
    }
}
