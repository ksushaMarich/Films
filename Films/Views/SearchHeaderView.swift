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
    #warning("Добавила переменные для того что бы использовать ее в SearchTextFeld")
    static let textFieldHeightAnchor = CGFloat(40)
    static let inset = CGFloat(10)
    
    weak var delegate: SearchHeaderViewDelegate?
    
    private var timer: Timer?
    
    private lazy var textField: SearchTextField = {
        let textField = SearchTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.delegate = self
        return textField
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
        contentView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -SearchHeaderView.inset),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SearchHeaderView.inset*2),
            textField.heightAnchor.constraint(equalToConstant: SearchHeaderView.textFieldHeightAnchor)
        ])
    }
}

extension SearchHeaderView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        timer?.invalidate()
        
        guard let currentText = textField.text, let textRange = Range(range, in: currentText)
        else { return true }
        
        let newText = currentText.replacingCharacters(in: textRange, with: string)
        
        //guard currentText.trimmingCharacters(in: .whitespacesAndNewlines) != newText.trimmingCharacters(in: .whitespacesAndNewlines)
        //else { return true }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: {_ in
            self.delegate?.search(newText)
        })
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            endEditing(true) 
            return true
       }
}
