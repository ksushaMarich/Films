//
//  Presenter.swift
//  Films
//
//  Created by Ксения Маричева on 20.12.2024.
//

import Foundation

class Presenter {
    //Это посредники между View и Model. Он получает пользовательские действия из View, запрашивает данные у Model и возвращает их обратно во View. Ведущий содержит всю логику приложения.
    
    private var popularMovies: [Movie] = []
    private lazy var movies: [Movie] = []
    
    private lazy var networkManager = NetworkManager.shared
    
    init() {
        Task {
            self.popularMovies = try await networkManager.searchMovies()
        }
    }
}
