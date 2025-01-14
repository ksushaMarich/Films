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
    
    #warning("Новая переменная таймер для задержки")
    private var timer: Timer?
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.delegate = self
        return textField
    }()
    
    private lazy var searchImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .systemGray
        view.image = UIImage(systemName: "magnifyingglass")
        return view
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
        contentView.addSubview(textField)
        textField.addSubview(searchImageView)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset*2),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            searchImageView.topAnchor.constraint(equalTo: textField.topAnchor, constant: inset),
            searchImageView.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -inset),
            searchImageView.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -inset),
        ])
    }
}

extension SearchHeaderView: UITextFieldDelegate {
    #warning("Добавила задержку")
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        timer?.invalidate()
        
        guard let currentText = textField.text, let textRange = Range(range, in: currentText)
        else { return true }
        
        #warning(" Добавила проверку на пробелы остальные знаки решила оставить вдруг они начало фильма")
        let newText = currentText.replacingCharacters(in: textRange, with: string)
        
        guard currentText != newText.trimmingCharacters(in: .whitespacesAndNewlines) else { return true }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: {_ in
            self.delegate?.search(newText)
        })
        
        return true
    }
}
