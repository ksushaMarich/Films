//
//  SearchCell.swift
//  Films
//
//  Created by Ксения Маричева on 09.12.2024.
//

import UIKit

protocol SearchCellDelegate: AnyObject {
    func update(with query: String)
}

class SearchCell: UITableViewCell {

    //MARK: - naming
    static var identifier = "SearchCell"
    
    weak var cellDelegate: SearchCellDelegate?
    
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
        button.setTitleColor(.black, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .red
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup cell methods
    
    private func setupView() {
        let inset = CGFloat(10)
        contentView.addSubview(textField)
        contentView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            searchButton.topAnchor.constraint(equalTo: textField.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: inset),
            searchButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            searchButton.widthAnchor.constraint(equalTo: searchButton.heightAnchor)
            ])
    }
    
    //MARK: - search method
    
    @objc func search() {
        guard let query = textField.text else { return }
        cellDelegate?.update(with: query)
        
    }
}
