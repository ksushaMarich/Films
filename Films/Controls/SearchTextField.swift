//
//  SearchTextField.swift
//  Films
//
//  Created by Ксюша on 15.01.2025.
//

import UIKit

class SearchTextField: UITextField {
    
    // MARK: - naming
    private let inset = SearchHeaderView.inset
    
    private lazy var padding = UIEdgeInsets(top: 0, left: SearchHeaderView.textFieldHeightAnchor - 0.5*inset, bottom: 0, right: inset)
    
    private lazy var searchImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemGray
        view.image = UIImage(systemName: "magnifyingglass")
        view.tintColor = .gray
        return view
    }()
    
    // MARK: - init
    init() {
        super.init(frame: .zero)
        attributedPlaceholder = NSAttributedString(string: "Поиск фильма" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        returnKeyType = .search
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - metods
    private func setupView() {
        addSubview(searchImageView)
        
        NSLayoutConstraint.activate([
            searchImageView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            searchImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            searchImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            searchImageView.widthAnchor.constraint(equalTo: searchImageView.heightAnchor)
        ])
    }
    
    // MARK: - override metods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
}
