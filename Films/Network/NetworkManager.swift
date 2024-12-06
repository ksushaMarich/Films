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
    let poster_path: String
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

//        // Создаем задачу для отправки запроса
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Ошибка: \(error.localizedDescription)") // Если есть ошибка, выводим её
//                return
//            }
//
//            // Убедимся, что данные получены
//            guard let data = data else {
//                print("Нет данных")
//                return
//            }
//
//            // Преобразуем данные в текст и печатаем
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Ответ сервера: \(jsonString)")
//            }
//        }
//
//        // Запускаем задачу
//        task.resume()
        
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
                self.movies = response.results
                print(self.movies)
                
            } catch {
                self.error = "Ошибка парсинга"
                return
            }
        }.resume()
    }
    
//    func downloadPosters() {
//        var posters: [UIImage?] = []
//        
//        for movie in movies {
//            
//            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)") else {
//                self.error = "url poster URL is not found "
//                return
//            }
//            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let error = error {
//                    self.error = " Ошибка загрузки изображения: \(error.localizedDescription)"
//                    posters.append(nil)
//                    return
//                }
//                guard let data = data, let image = UIImage(data: data) else { return }
//                posters.append(image)
//            }
//        }
//        self.posters = posters
//    }
}
