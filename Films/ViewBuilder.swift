//
//  MainViewBuilder.swift
//  Films
//
//  Created by Ксюша on 29.12.2024.
//

import UIKit

enum ViewType {
    case main
    case movieDetails(id: Int, poster: UIImage?)
}

class ViewBuilder {
    
    static func build(type: ViewType) -> UIViewController {
        
        switch type {
        case .main:
            let view = MainViewController()
            let presenter = MainViewPresenter()
            view.presenter = presenter
            presenter.view = view
            return UINavigationController(rootViewController: view)
        case .movieDetails(let id, let poster):
            let view = MovieDetailsController(id: id)
            view.poster = poster
            let presenter = MovieDetailsPresenter()
            view.presenter = presenter
            presenter.view = view
            return view
        }
    }
}
