//
//  SearchHeaderView.swift
//  Films
//
//  Created by Ксюша on 16.12.2024.
//

import UIKit

protocol SearchHeaderViewDelegate: AnyObject {
    func search(_ query: String)
}

class SearchHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - naming
    static let identifier = "SearchHeaderView"
    
    weak var delegate: SearchHeaderViewDelegate?
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    //MARK: - init
    init() {
        super.init(reuseIdentifier: SearchHeaderView.identifier)
        contentView.backgroundColor = .black
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup view methods
    
    private func setupView() {
        let inset = CGFloat(10)
        addSubview(textField)
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            searchButton.topAnchor.constraint(equalTo: textField.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: inset),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset)
        ])
    }
    
    //MARK: - search method
    
    @objc func search() {
        delegate?.search(textField.text ?? "")
    }
}
