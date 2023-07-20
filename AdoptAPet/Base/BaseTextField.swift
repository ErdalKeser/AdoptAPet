//
//  BaseTextField.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 23.06.2023.
//

import UIKit

class CustomTextFild : UITextField {
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = .black.withAlphaComponent(0.3)
        setHeight(50)
        layer.cornerRadius = 5
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
