//
//  EditProfileCollectionViewCell.swift
//  MeaningOut
//
//  Created by 여누 on 6/17/24.
//

import UIKit

class EditProfileCollectionViewCell: UICollectionViewCell {
    static let id = "EditProfileCollectionViewCell"
    
    let mainView = UIView()
    let profileImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(mainView)
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 35
        contentView.addSubview(mainView)
        mainView.addSubview(profileImage)
        
        
        mainView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        //profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 35.5
        profileImage.layer.borderWidth = 3
        
        profileImage.snp.makeConstraints { make in
            make.edges.equalTo(mainView.safeAreaLayoutGuide)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
