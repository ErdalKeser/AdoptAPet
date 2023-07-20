//
//  ProfileController.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 21.06.2023.
//

import UIKit
import Firebase

private let cellIdentifer = "ProfileCell"


class ProfileController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var posts = [Post]() {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    var user:User?{
        didSet {
            guard let userName = user?.fullname else {return}
            guard let profileImage = user?.profileImageUrl else {return}
            profileImageView.sd_setImage(with: URL(string: profileImage))
            usernameLabel.text = userName
            collectionView.reloadData()
            
        }
    }
    
    private var collectionView: UICollectionView!
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    private lazy var backImageViewProfile: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setDimensions(height: 140, width: 140)
        view.layer.cornerRadius = 140 / 2
        return view
    }()
    
    private lazy var backImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .white
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.image = UIImage(named: "backImage")!
        return iv
    }()
    
    private lazy var appName: UILabel = {
        let label = UILabel()
        label.text = "a d o p t  a  p e t "
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.backgroundColor = .white.withAlphaComponent(0.3)
        label.textColor = .black
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    var logoutButton:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black.withAlphaComponent(0.8)
        button.frame = CGRect(x: 130, y: 100, width: 200, height: 100)
        button.addTarget(self, action: #selector(showLogout), for: .touchUpInside)
        button.layer.cornerRadius = 7
        
        return button
    }()
    @objc func showLogout(){
        
        do {
            try Auth.auth().signOut()
            let controller = EntryController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }
        catch {
            print("Debug: Failed to sign out")
        }
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        fetchPosts()
        setupCollectionView()
        configureUI()
        divider()
        fetchUser()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
    }
    
    func divider(){
        let topDivider = UIView()
        let centerDivider = UIView()
        let bottomDivider = UIView()
        
        topDivider.backgroundColor = .black
        centerDivider.backgroundColor = .black
        bottomDivider.backgroundColor = .black
 
        
    }
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionViewHeight: CGFloat = 450
        let collectionViewFrame = CGRect(x: 0, y: 310, width: view.bounds.width, height: collectionViewHeight)
        
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(collectionView)
    }
    
    func configureUI(){
        
        view.addSubview(backImageView)
        backImageView.anchor(top: view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,paddingTop: -75,width: UIScreen.main.bounds.width,height: 300)
        view.addSubview(appName)
        appName.anchor(top: view.topAnchor,left: view.leftAnchor,right: view.rightAnchor,height: 210)
        view.addSubview(backImageViewProfile)
        backImageViewProfile.anchor(top: view.topAnchor
                            ,paddingTop: 140)
        backImageViewProfile.centerX(inView: view)
        
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.topAnchor
                                ,paddingTop: 150)
        profileImageView.centerX(inView: view)
        
        profileImageView.setDimensions(height: 120, width: 120)
        profileImageView.layer.cornerRadius = 120 / 2
        
        view.addSubview(usernameLabel)
        usernameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 10)
        usernameLabel.centerX(inView: view)
        usernameLabel.setDimensions(height: 30, width: 150)
        view.addSubview(logoutButton)
        logoutButton.anchor(top: collectionView.bottomAnchor,left: collectionView.leftAnchor,right: collectionView.rightAnchor,paddingTop: 30, paddingLeft: 150,paddingRight: 150)
        
    }
    
    func fetchPosts(){
        
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let query = COLLECTİON_ALL.whereField("ownerUid", isEqualTo: uid)
                        query.getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {return}
                
                var post = documents.map({Post(dictionary: $0.data())})
                
                post.sort(by: { $0.timestamp.seconds > $1.timestamp.seconds })
                self.posts = post
            }
        }
    
    func fetchUser(){
        
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let query = COLLECTİON_ALL.whereField("ownerUid", isEqualTo: uid)
            
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            
            guard let dictionary = snapshot?.data() else { return }
            self.user = User(dictionary: dictionary)
            
        }
            
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProfileCell
  
        cell.urlsss = posts[indexPath.row].imageUrl

        return cell
    }
  
}

extension ProfileController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProfileController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let navigationController = navigationController {
            navigationController.navigationBar.isHidden = scrollView.contentOffset.y > 0
        }
    }
}

extension ProfileController{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-2) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 20)
    }
    
}


