//
//  ViewController.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

class StartViewController: UIViewController {
    
    //MARK: - naming
    
    private lazy var mainView: StartView = {
        let view = StartView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NetworkManager.shared.searchMovies(query: "убить била")
    }
    
    //MARK: - setupViewMethods
    
    private func setupView() {
        view.addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension StartViewController: StartViewDelegate {
    func didTapSearchButton(with text: String) {
        let networkManager = NetworkManager.shared
        networkManager.searchMovies(query: text)
        guard let error = networkManager.error else {
            navigationController?.pushViewController(RespondViewController(movies: networkManager.movies), animated: true)
            return
        }
        print(error)
    }
}

