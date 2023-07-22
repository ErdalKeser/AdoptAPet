//
//  FeedController.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 21.06.2023.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

protocol FeedControllerProtocol: AnyObject{
    
    func sendPost(post:[Post])
}

class FeedController: UICollectionViewController, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    
    private let feedVM = FeedVM()
    
    private var posts = [Post]() {
        didSet {
            collectionView.reloadData()
            if posts.isEmpty == false {
                let indexPath = IndexPath(row: 0, section: 0)
                collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
                
            }
        }
    }
    
    var post: Post? {
        didSet {
            collectionView.reloadData()

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        feedVM.delegate = self
        configureUI()
        self.feedVM.fetchPosts(genus: "All", city: "Turkey")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.feedVM.fetchPosts(genus: "All", city: "Turkey")
        navigationItem.title = "All in Turkey"
    }


    func showMessage(){

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .black.withAlphaComponent(0.7)

            let title = NSAttributedString(string: "NO RESULTS!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
            alertController.setValue(title, forKey: "attributedTitle")
            
            let message = NSAttributedString(string: "Dont have a feed..", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
            alertController.setValue(message, forKey: "attributedMessage")
        
            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                self.feedVM.fetchPosts(genus: "All", city: "Turkey")
                self.navigationItem.title = "All in Turkey"
            }
            action.setValue(UIColor.white, forKey: "titleTextColor")
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
    }
    
        
    func configureUI(){
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if post == nil {

            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_button"), style: .plain, target: self, action: #selector(handleFilter))
            navigationItem.title = "All in TURKEY"
        }
        
    }

    @objc func handleFilter(){
        
        let controller = FilteringController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .custom
        nav.transitioningDelegate = self
        self.present(nav, animated: true)
        
    }
}

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        cell.delegate = self
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
            navigationItem.title = "My Post"
            print("")

            
        }else {
            
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
            
        }
        
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 276
        return CGSize(width: width, height: height)
    }
    
}

class HalfScreenPresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
            guard let containerView = containerView else { return CGRect.zero }
            return CGRect(x: 0, y: containerView.bounds.height / 2, width: containerView.bounds.width, height: containerView.bounds.height / 2)
        }

}
extension FeedController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfScreenPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
extension FeedController: incomingData {
    func data(genus: String, city: String) {
        print("cins: \(genus) \(city)")
        
        feedVM.fetchPosts(genus: genus, city: city)
        
        navigationItem.title = "\(genus) in \(city)"
    }
    
}
extension FeedController: FeedCellDelegate {
    
    func explain(explain: String) {
        let controller = ExplainController()
        controller.explain = explain
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .custom
        nav.transitioningDelegate = self
        nav.presentationController?.delegate = self
        self.present(nav, animated: true)
    }
   
}
extension FeedController: FeedControllerProtocol {
    func sendPost(post: [Post]) {
        posts = post
        if post.isEmpty == true {
            self.showMessage()
        }
        
    }
    
}


