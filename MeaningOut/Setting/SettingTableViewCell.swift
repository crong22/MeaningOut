//
//  SettingTableViewCell.swift
//  MeaningOut
//
//  Created by 여누 on 6/16/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    static let id = "SettingTableViewCell"
    let listLabel = UILabel()
    let likeImage = UIImageView()
    let likeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(listLabel)
        contentView.addSubview(likeImage)
        contentView.addSubview(likeLabel)
        
        listLabel.font = .systemFont(ofSize: 15, weight: .medium)
        listLabel.textColor = .black
        listLabel.textAlignment = .left
        listLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        likeImage.tintColor = .black
        likeImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(80)
            make.height.width.equalTo(25)
        }
        
        likeLabel.textAlignment = .left
        likeLabel.font = .systemFont(ofSize: 15, weight: .medium)
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

