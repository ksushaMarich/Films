//
//  Movie.swift
//  Films
//
//  Created by Ксюша on 08.12.2024.
//

import Foundation

// MARK: - error
enum APIError: Error {
    case invalidURL
    case badData
    case serverError
    case decodingError
}

extension APIError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .badData: return "No data"
        case .serverError: return "Проверьте подключение"
        case .decodingError: return "Decoding error"
        }
    }
}

// MARK: - for movie view
struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    
    let id: Int
    let title: String
    let overview: String
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case poster = "poster_path"
    }
}

//MARK: - for movie details
struct MovieDetails: Decodable {
    let budget: Int
    let genres: [Genre]
    let overview: String
    let poster: String?
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case budget, genres, overview, title
        case poster = "poster_path"
    }
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
