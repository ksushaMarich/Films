//
//  Movie.swift
//  Films
//
//  Created by Ксюша on 08.12.2024.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case serverError
    case decodingError
    case emptyMovies
}

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


/*
 private let booleanNum: Int
 
 var booleanValue: Bool {
     booleanNum > 0
 }
 */

