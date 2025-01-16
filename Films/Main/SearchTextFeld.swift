//
//  SearchTextFeld.swift
//  Films
//
//  Created by Ксюша on 15.01.2025.
//

import UIKit
#warning("Новый класс для того что бы задать отступы")
class SearchTextFeld: UITextField {

    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    init() {
        super.init(frame: .zero)
        attributedPlaceholder = NSAttributedString(string: "Поиск фильма" , attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
