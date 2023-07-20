//
//  ProfileCell.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 11.07.2023.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    
    var urlsss:String?{
        didSet {
            
           postImageView.sd_setImage(with: URL(string: urlsss!))
           
        }
    }
    
    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
