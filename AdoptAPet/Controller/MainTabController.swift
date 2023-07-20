//
//  MainTabController.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 21.06.2023.
//

import UIKit
import Firebase
import YPImagePicker

class MainTabController: UITabBarController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checIfUserIsLoggedIn()
        configureViewController()
        navigationController?.navigationBar.isHidden = true
        navigationController?.modalPresentationStyle = .fullScreen
        fetchUser()
    }
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
                UserService.fetchUser(withUid: uid){user in
                self.user = user
            }
        }
    
    func checIfUserIsLoggedIn(){
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = EntryController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
        
    }
    
    func configureViewController(){
        
        self.delegate = self
        
        view.backgroundColor = .white
        
        let feedLayout = UICollectionViewFlowLayout()
        
        let feed = templateNavigationController(unselectedImage: UIImage(named: "home_unselected")!, selectedImage: UIImage(named: "home_selected")!, rootViewController: FeedController(collectionViewLayout: feedLayout))

        let imageSelector = templateNavigationController(unselectedImage: UIImage(named: "plus_photo")!, selectedImage: UIImage(named: "plus_unselected")!, rootViewController: ImageSelectorController())
        
        let profileController = ProfileController()
        let profile = templateNavigationController(unselectedImage: UIImage(named: "profile_unselected")!, selectedImage: UIImage(named: "profile_selected")!, rootViewController: profileController)
        
        viewControllers = [feed,imageSelector, profile]
        
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }
    func didFinishPickingMedia(_ picker: YPImagePicker){
        
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: false){
                guard let selectedImage = items.singlePhoto?.image else {return}
                let controller = UploadPostController()
                controller.selectedImage = selectedImage
                controller.delegate = self
                controller.currentUser = self.user
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
            
        }
        
    }
}

extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
    }
}
extension MainTabController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 1 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true)
            didFinishPickingMedia(picker)
        }
       
        return true
    }
   
}
extension MainTabController: UploadPostControllerDelegate {
    
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true)
        guard let feedNav = viewControllers?.first as? UINavigationController else {return}
        guard let feed = feedNav.viewControllers.first as? FeedController else {return}
    }
    
}


