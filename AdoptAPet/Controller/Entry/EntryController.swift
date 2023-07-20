//
//  EntryController.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 21.06.2023.
//


import UIKit

class EntryController: UIViewController, UIScrollViewDelegate {
    
    weak var delegate: AuthenticationDelegate?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let overlayView: UIView = {
        let overlayView = UIView()
        
        overlayView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        return overlayView
    }()
    private let overlayView2: UIView = {
        let overlayView = UIView()
        
        overlayView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        return overlayView
    }()
    private let overlayView3: UIView = {
        let overlayView = UIView()
        
        overlayView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        return overlayView
    }()
    private let firstView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pet_logo")
        view.backgroundColor = .white
        
        return view
    }()
    
    private let secondView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pet_logo2")
        view.backgroundColor = .white
        return view
    }()
    
    private let thirdView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pet_logo3")
        return view
    }()
    
    private lazy var firstViewLabel: UILabel = {
        let label = UILabel()
        label.text = "W E L C O M E"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        return label
    }()
    
    private lazy var firstViewLabel2: UILabel = {
        let label = UILabel()
        label.text = "a d o p t  a  p e t "
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        return label
    }()
    private lazy var firstViewLabel3: UILabel = {
        let label = UILabel()
        label.text = "slide right  >"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var secondViewLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Let no friend of ours remain homeless, with this application we bring animal lovers and our friends together. Sign up now and meet our friends or find a new home for our homeless friends..."
        label.numberOfLines = 30
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    private lazy var secondViewLabel2: UILabel = {
        
        let label = UILabel()
        label.text = "slide right  >"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var thirdViewLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Sign in to meet our animal friends or give them a new home.."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 50
        label.textColor = .white
        return label
    }()
    
    private lazy var thirdViewLabel2: UILabel = {
        
        let label = UILabel()
        label.text = "If you dont have an account? Sign Up"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 10
        label.textColor = .white
        return label
    }()
    
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        return pageControl
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.80), for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.3)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(EntryController.handleLogin), for: .touchUpInside)
        
        
        return button
    }()
    private let registerButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor(white: 1, alpha: 0.80), for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.3)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.isEnabled = true
        button.addTarget(self, action: #selector(handleRegisteration), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleLogin(){
        
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
   
    }
    @objc func handleRegisteration(){
        DispatchQueue.main.async {
            let controller = RegistrationController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureScrollView()
        configurePageControl()
    }
    
    private func configureScrollView() {
        
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor)
        
        scrollView.addSubview(firstView)
        scrollView.anchor(top: view.topAnchor,left: view.leftAnchor,bottom: view.bottomAnchor,right: view.rightAnchor)
        
        firstView.translatesAutoresizingMaskIntoConstraints = false
        firstView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        firstView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        firstView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        firstView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        scrollView.addSubview(secondView)
        secondView.translatesAutoresizingMaskIntoConstraints = false
        secondView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        secondView.leadingAnchor.constraint(equalTo: firstView.trailingAnchor).isActive = true
        secondView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        secondView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        scrollView.addSubview(thirdView)
        thirdView.translatesAutoresizingMaskIntoConstraints = false
        thirdView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        thirdView.leadingAnchor.constraint(equalTo: secondView.trailingAnchor).isActive = true
        thirdView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        thirdView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        thirdView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
       
        firstView.addSubview(overlayView)
        overlayView.anchor(top: firstView.topAnchor, left: firstView.leftAnchor,
                           bottom: firstView.bottomAnchor, right: firstView.rightAnchor)
        
        overlayView.addSubview(firstViewLabel)
        firstViewLabel.center(inView: firstView)
        overlayView.addSubview(firstViewLabel2)
        firstViewLabel2.centerX(inView: overlayView)
        firstViewLabel2.anchor(top: overlayView.topAnchor, paddingTop: UIScreen.main.bounds.width*1.2)
        overlayView.addSubview(firstViewLabel3)
        firstViewLabel3.centerX(inView: overlayView)
        firstViewLabel3.anchor(bottom: overlayView.bottomAnchor,paddingBottom: 40)
        
        secondView.addSubview(overlayView2)
        overlayView2.anchor(top: secondView.topAnchor, left: secondView.leftAnchor,
                            bottom: secondView.bottomAnchor, right: secondView.rightAnchor)
        
        overlayView2.addSubview(secondViewLabel)
        secondViewLabel.anchor(top: overlayView2.topAnchor,left: overlayView2.leftAnchor,paddingTop: 150 ,paddingLeft: 50,width: 250,height: 500)
        overlayView2.addSubview(secondViewLabel2)
        
        secondViewLabel2.centerX(inView: overlayView2)
        secondViewLabel2.anchor(bottom: overlayView2.bottomAnchor,paddingBottom: 40)
        
        thirdView.addSubview(overlayView3)
        overlayView3.anchor(top: thirdView.topAnchor, left: thirdView.leftAnchor,
                            bottom: thirdView.bottomAnchor, right: thirdView.rightAnchor)
        overlayView3.addSubview(thirdViewLabel)
        thirdViewLabel.anchor(top: overlayView3.topAnchor,left: overlayView3.leftAnchor,paddingTop: 100,paddingLeft: 20,width: 250,height: 250)
        overlayView3.addSubview(thirdViewLabel2)
        thirdViewLabel2.anchor(top: overlayView3.topAnchor,left: overlayView3.leftAnchor,paddingTop: 378, paddingLeft: 20,width: 500,height: 250)
        
        view.addSubview(loginButton)
        
        loginButton.anchor(top: overlayView3.topAnchor,left: overlayView3.leftAnchor,right: overlayView3.rightAnchor,paddingTop: UIScreen.main.bounds.width,paddingLeft: 15,paddingRight: 15)
        
        view.addSubview(registerButton)
        
        registerButton.anchor(top: overlayView3.topAnchor,left: overlayView3.leftAnchor,right: overlayView3.rightAnchor,paddingTop: UIScreen.main.bounds.width*1.25 , paddingLeft: 15,paddingRight: 15)
        
    }
    
    private func configurePageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

