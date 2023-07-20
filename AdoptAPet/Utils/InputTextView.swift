//
//  InputTextView.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 3.07.2023.
//

import UIKit

class InputTextView: UITextView {
    
    var placeholderText: String? {
        didSet { placeholderLabel.text = placeholderText }
    }
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    var placeholderShouldCenter = true {
        
        didSet {
            if placeholderShouldCenter {
                placeholderLabel.anchor(left: leftAnchor, right:  rightAnchor, paddingLeft: 8)
                placeholderLabel.centerY(inView: self)
            }else {
                placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
            }
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeholderLabel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func handleTextDidChange(){
        placeholderLabel.isHidden = !text.isEmpty
    }
}
