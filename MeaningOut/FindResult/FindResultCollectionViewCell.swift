//
//  FindResultCollectionViewCell.swift
//  MeaningOut
//
//  Created by 여누 on 6/15/24.
//

import UIKit
import SnapKit

protocol FindResultCollectionViewCellDelegate: AnyObject {
    func didTapLikeButton(at indexPath: IndexPath, item: NaverInfo)
}


class FindResultCollectionViewCell: UICollectionViewCell {
    
    static let id = "FindResultCollectionViewCell"
    let imageView = UIImageView()
    let storeLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let likeButton = UIButton()
    
    weak var delegate: FindResultCollectionViewCellDelegate?
    var indexPath: IndexPath?
    var item: NaverInfo?
    var isLiked: Bool = false {
        didSet {
//            let imageName = isLiked ? "like_selected" : "like_unselected"
//            likeButton.setImage(UIImage(named: imageName), for: .normal)
            updateLikeButtonImage()
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(storeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
        
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(220)
        }
        
        storeLabel.font = .systemFont(ofSize: 10, weight: .regular)
        storeLabel.textAlignment = .left
        storeLabel.textColor = .lightGray
        storeLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(60)
        }
        
        titleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(storeLabel.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(35)
        }
        
        priceLabel.font = .systemFont(ofSize: 14, weight: .heavy)
        priceLabel.textAlignment = .left
        priceLabel.textColor = .black
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
        likeButton.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        likeButton.layer.cornerRadius = 5
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(imageView).inset(10)
            make.trailing.equalTo(imageView).offset(-10)
            make.width.height.equalTo(30)
        }
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with item: NaverInfo) {
        self.item = item
        self.isLiked = item.like
        let imageName = isLiked ? "like_selected" : "like_unselected"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    

    
    func updateLikeButtonImage() {
        let imageName = isLiked ? "like_selected" : "like_unselected"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
//    @objc func likeButtonClicked() {
//        isLiked.toggle()
//        item?.like = isLiked
//        updateLikeButtonImage()
//        if let indexPath = indexPath, let item = item {
//            delegate?.didTapLikeButton(at: indexPath, item: item)
//        }
//    }
  
    @objc func likeButtonTapped() {
        isLiked.toggle()
        // Notify the view controller about the like button tap
        NotificationCenter.default.post(name: NSNotification.Name("likeButtonTapped"), object: nil, userInfo: ["indexPath": indexPath, "isLiked": isLiked])
    }

}
