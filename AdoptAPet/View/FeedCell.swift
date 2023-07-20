//
//  FeedCell.swift
//  AdoptAPet
//
//  Created by Erdal Keser on 25.06.2023.
//



import UIKit
import SDWebImage


protocol FeedCellDelegate: AnyObject {
    func explain(explain:String)
}

class FeedCell: UICollectionViewCell {
    
    var viewModel: PostViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: FeedCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .lightGray
        
        return iv
    }()
    
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        return button
    }()
    
    private lazy var postImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .white
        return iv
    }()
    
    private lazy var commentButton: UIButton = {
                let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)

        return button
    }()

    
    private let postTimeLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .lightGray
        
        return label
        
    }()
    
    private let explainLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .black

        return label
    }()
    
    private lazy var explainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "add_button"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapComments), for: .touchUpInside)

        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(postImageView)
        postImageView.anchor(top: contentView.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 15)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        addSubview(profileImageView)
        profileImageView.anchor(top: postImageView.bottomAnchor, left: leftAnchor
                                ,paddingTop: 30,paddingLeft: 20)
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView,
                               leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
        
        addSubview(explainLabel)
        explainLabel.anchor(top: profileImageView.bottomAnchor,left: contentView.leftAnchor,right: contentView.rightAnchor,paddingTop: 20,paddingLeft: 10,paddingRight: 50)
        
        addSubview(explainButton)
        explainButton.anchor(bottom: explainLabel.bottomAnchor,right: contentView.rightAnchor,paddingTop: 10,paddingRight: 10,width: 23,height: 23)
        
        addSubview(postTimeLabel)
        
        postTimeLabel.anchor(top: explainButton.bottomAnchor,right: contentView.rightAnchor,paddingTop: 30,paddingRight: 20)
        
    }
    
    func divider(){
        let mainDivider = UIView()
        let bottomDivider = UIView()
        mainDivider.backgroundColor = .black
        bottomDivider.backgroundColor = .black
        contentView.addSubview(mainDivider)
        contentView.addSubview(bottomDivider)
        
        mainDivider.anchor(top: contentView.topAnchor,left: contentView.leftAnchor,right: contentView.rightAnchor,paddingTop: 1,paddingLeft: 10,paddingRight: 10, height: 1)

        bottomDivider.anchor(top: explainLabel.bottomAnchor,left: contentView.leftAnchor,right: contentView.rightAnchor,paddingTop: 60,paddingLeft: 10,paddingRight: 10,height: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc func didTapComments(){
        delegate?.explain(explain: viewModel?.caption ?? "erdal")
        
    }

    func configure(){
        
        guard let viewModel = viewModel else { return }
        postImageView.sd_setImage(with: viewModel.imageUrl)
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
        postTimeLabel.text = "\(viewModel.timestampString!)"
        explainLabel.text = viewModel.caption
        divider()
 
    }
    
}
