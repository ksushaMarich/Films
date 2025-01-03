//
//  MainViewBuilder.swift
//  Films
//
//  Created by Ксюша on 29.12.2024.
//

import UIKit

#warning("сдела билдер общим")

enum ViewType {
    case main
    case movieDetails
}
class ViewBuilder {
    
    static func build(type: ViewType, id: Int? = nil) -> UIViewController {
        
        switch type {
        case .main:
            let view = MainViewController()
            let presenter = MainViewPresenter()
            
            view.presenter = presenter
            presenter.view = view
            return UINavigationController(rootViewController: view)
        case .movieDetails:
            let view = MovieDetailsController(id: id)
            let presenter = MovieDetailsPresenter()
            
            view.presenter = presenter
            presenter.view = view
            return view
        }
    }
}
