//
//  ExplainController.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 12.07.2023.
//

import UIKit


class ExplainController: UIViewController {
    
    var explain:String? {
        didSet {
            explainLabel.text = explain
        }
    }
    
    private let explainLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 10
        label.textAlignment = .natural
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        
        return label
    }()
    
    private let explainTitle: UILabel = {

        let label = UILabel()
        label.text = "EXPLAIN"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white

        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDismissGesture()
        view.backgroundColor = .black.withAlphaComponent(0.9)
        configureLabel()
       
    }
    func configureLabel(){
        
                view.addSubview(explainTitle)
        explainTitle.anchor(top: view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 30,paddingLeft: 150,paddingRight: 150)
        
        view.addSubview(explainLabel)
        explainLabel.anchor(top: view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 70,paddingLeft: 10,paddingRight: 10)
        
    }
    
    private func setupDismissGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDismissGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }

    @objc private func handleDismissGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let verticalOffset = translation.y
        
        switch gesture.state {
        case .changed:
            if verticalOffset > 0 {
                view.transform = CGAffineTransform(translationX: 0, y: verticalOffset)
            }
            
        case .ended, .cancelled:
            let velocity = gesture.velocity(in: view)
            if verticalOffset > 0 && velocity.y > 0 {
                dismiss(animated: true, completion: nil)
            } else {
               
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = .identity
                }
            }
            
        default:
            break
        }
    }

}

