//
//  Presenter.swift
//  Films
//
//  Created by Ксения Маричева on 20.12.2024.
//

import Foundation

class MainViewPresenter {
    //Это посредники между View и Model. Он получает пользовательские действия из View, запрашивает данные у Model и возвращает их обратно во View. Ведущий содержит всю логику приложения.
    
    
    private let networkManager = NetworkManager.shared
    
    lazy var popularMovies: [Movie] = networkManager.popularMovies
    private lazy var movies: [Movie] = []
}

extension MainViewPresenter: MainViewControllerDelegate {
    
    func searchMovies(with query: String) async -> [Movie] {
        do {
            movies = try await NetworkManager.shared.searchMovies(query: query)
            return movies
        } catch {
            print("ошибка")
            return []
        }
    }
}
