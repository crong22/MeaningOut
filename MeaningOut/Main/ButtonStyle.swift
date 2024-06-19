//
//  ButtonStyle.swift
//  MeaningOut
//
//  Created by 여누 on 6/14/24.
//

import UIKit

class ButtonStyle : UIButton {
    
    init(title : String){
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        setTitleColor(UIColor(ciColor: .white), for: .normal)
        backgroundColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
