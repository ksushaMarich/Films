//
//  ViewController.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - naming
    
    private lazy var mainView: MainView = {
        let view = MainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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

