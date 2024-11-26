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
        backgroundColor = .red
        setupView()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=5e491b5e3a7e7c82df6c07d1c7448db1")!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Нет данных")
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("Ответ: \(json)")
            }
        }

        task.resume()
        
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
