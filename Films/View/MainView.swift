//
//  MainView.swift
//  Films
//
//  Created by User on 25.11.2024.
//

import UIKit

class MainView: UIView {
    
    //MARK: - naming
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 14
        textField.backgroundColor = .white
        return textField
    }()
    
    //MARK: - init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupViewMethods
    private func setupView() {
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 8/10),
        ])
    }
}
