//
//  MainView.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

protocol StartViewDelegate: AnyObject {
    func didTapSearchButton(with text: String)
}

class StartView: UIView {
    
    //MARK: - naming
    
    weak var delegate: StartViewDelegate?
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 14
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        button.setTitle("ИСКАТЬ", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14
        return button
    }()
    
    //MARK: - init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .red
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup viewMethods
    private func setupView() {
        addSubview(textField)
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 8/10),
            
            searchButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            searchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 8/10),
        ])
    }
    
    //MARK: - button methods
    @objc func search() {
        guard let query = textField.text else { return }
        delegate?.didTapSearchButton(with: query)
    }
}
