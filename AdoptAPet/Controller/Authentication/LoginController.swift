//
//  LoginController.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 22.06.2023.
//

import UIKit
import FirebaseAuth

protocol AuthenticationDelegate: AnyObject {
    func authenticationDidComplete()
}

class LoginController: UIViewController {
    
    var email: String?
    var password: String?
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    weak var delegate: AuthenticationDelegate?
    
    private lazy var logoImage: UIImageView = {
        
        let iv = UIImageView()
        iv.image = UIImage(named: "adopt_logo")
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(height: 250, width: 250)
        return iv
    }()
    
    private let emailTextField: CustomTextFild = {
        let tf = CustomTextFild(placeHolder: "Email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: CustomTextFild = {
        let tf = CustomTextFild(placeHolder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.backgroundColor = .brown.withAlphaComponent(0.3)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Dont have an account?", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    private let overlayView: UIView = {
        
        let overlayView = UIView()
        overlayView.backgroundColor = .systemOrange.withAlphaComponent(0.3)
        return overlayView
        
    }()
    
    @objc func handleLogin(){
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.logUserIn(withEmail: email, password: password) { _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.delegate?.authenticationDidComplete()
            DispatchQueue.main.async {
                let controller = MainTabController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                nav.navigationBar.isHidden = true
                self.present(nav, animated: true)
            }
        }
        
    }
    @objc func handleShowSignUp(){
        
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField {
            email = sender.text
        }else {
            password = sender.text
        }
        updateForm()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationObservers()
        
    }
    
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(logoImage)
        logoImage.anchor(top: view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: 100,paddingLeft: 10,paddingRight: 10)
        view.addSubview(overlayView)
        overlayView.fillSuperview()
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        overlayView.addSubview(stack)
        stack.anchor(top: overlayView.topAnchor, left: overlayView.leftAnchor,right: overlayView.rightAnchor,paddingTop: 430,paddingLeft: 15,paddingRight: 15)
        overlayView.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: overlayView)
        dontHaveAccountButton.anchor(bottom: overlayView.safeAreaLayoutGuide.bottomAnchor)
        
    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func updateForm() {
        if formIsValid == true {
            loginButton.backgroundColor = .brown.withAlphaComponent(0.9)
            loginButton.isEnabled = true
            
        }else {
            loginButton.backgroundColor = .brown.withAlphaComponent(0.3)
            loginButton.isEnabled = false
        }
        
    }
    
}
