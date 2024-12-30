//
//  MainViewBuilder.swift
//  Films
//
//  Created by Ксюша on 29.12.2024.
//

import UIKit

protocol MainViewInput: AnyObject {
    var presenter: MainViewOutput? { get set }
    func update(with movies: [Movie])
}

protocol MainViewOutput: AnyObject {
    var view: MainViewInput? { get set }
    func searchMovies(with query: String)
}

class MainViewBuilder {
    
    static func build() -> UIViewController {
        
        let view = MainViewController()
        let presenter = MainViewPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        return UINavigationController(rootViewController: view)
    }
}
