//
//  RegistrationController.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 22.06.2023.
//

import UIKit
import Firebase


class RegistrationController: UIViewController {
    
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    var profileImages: UIImage?
    
    weak var delegate: AuthenticationDelegate?

    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    private let overlayView: UIView = {
        let overlayView = UIView()
                
        overlayView.backgroundColor = .systemOrange.withAlphaComponent(0.3)
        
        return overlayView
    }()
    
    private let plushPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "plus_photo1"), for: .normal)
    button.tintColor = .white
    button.setDimensions(height: 250, width: 250)
    button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
        
    return button
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
    private let fullnameTextField = CustomTextFild(placeHolder: "Fullname")
    private let usernameTextField = CustomTextFild(placeHolder: "Username")
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.67), for: .normal)
        button.backgroundColor = .brown.withAlphaComponent(0.3)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.isEnabled = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?", secondPart: "Sign In")
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        return button
    }()
    
    @objc func handleProfilePhotoSelect(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    @objc func handleSignUp(){
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullname = fullnameTextField.text else {return}
        guard let username = usernameTextField.text?.lowercased() else {return}
        guard let profileImage = self.profileImages else {return}
        
        let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, profileImage: profileImage)
        
        AuthService.registerUser(withCredential: credentials){error in
            if let error = error {
            print("debug: Failed to register user\(error.localizedDescription)")
            return
            }
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
            
        }
      
    }
    @objc func handleShowSignIn(){
        
        navigationController?.popViewController(animated: true)

        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
        
    }
    @objc func textDidChange(sender: UITextField){
        if sender == emailTextField {
            email = sender.text
        }else if sender == passwordTextField {
            password = sender.text
        }else if sender == fullnameTextField {
            fullname = fullnameTextField.text
        } else {
            username = usernameTextField.text
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
        view.addSubview(overlayView)
        overlayView.fillSuperview()
        overlayView.addSubview(plushPhotoButton)
        plushPhotoButton.centerX(inView: overlayView)
        plushPhotoButton.anchor(top: overlayView.topAnchor,left: overlayView.leftAnchor,right: overlayView.rightAnchor,paddingTop: 50,paddingLeft: 10,paddingRight: 10)
        
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField,usernameTextField,signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: overlayView.topAnchor, left: overlayView.leftAnchor,right: overlayView.rightAnchor,paddingTop: 300,paddingLeft: 32,paddingRight: 32)
        
        overlayView.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: overlayView)
        alreadyHaveAccountButton.anchor(bottom: overlayView.safeAreaLayoutGuide.bottomAnchor)

    }
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func updateForm() {
        if formIsValid == true {
            signUpButton.backgroundColor = .brown.withAlphaComponent(0.9)
            signUpButton.isEnabled = true
            
        }else {
            signUpButton.backgroundColor = .brown.withAlphaComponent(0.3)
            signUpButton.isEnabled = false
        }
        
    }
}
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        profileImages = selectedImage
        plushPhotoButton.layer.cornerRadius = plushPhotoButton.frame.width / 2
        plushPhotoButton.layer.masksToBounds = true
        plushPhotoButton.layer.borderColor = UIColor.white.cgColor
        plushPhotoButton.layer.borderWidth = 2
        plushPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true)
    }
    
}
