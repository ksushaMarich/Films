//
//  NM.swift
//  Films
//
//  Created by Ксения Маричева on 12.01.2025.
//

import Foundation

class NM {
    private static let networkManager = NetworkManager.shared
    
    static func searchMovies(query: String? = nil, success: @escaping ([Movie]) -> Void,
                             failure: @escaping (String) -> Void) {
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
}
