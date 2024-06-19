//
//  MainViewController.swift
//  MeaningOut
//
//  Created by 여누 on 6/14/24.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let titleLabel = UILabel()
    let mainImageView = UIImageView()
    let startButton = ButtonStyle(title: "시작하기")

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        UserDefaults.standard.setValue(false, forKey: "isUser")
        
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(mainImageView)
        view.addSubview(startButton)
    }
    
    func configureLayout() {
        view.backgroundColor = .white

        titleLabel.text = "MeaningOut"
        titleLabel.font = .systemFont(ofSize: 44, weight: .black)
        titleLabel.textColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        titleLabel.textAlignment = .center
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        mainImageView.image = UIImage(named: "launch")
        mainImageView.contentMode = .scaleAspectFit
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(400)
        }
        
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(44)
        }
    }

}
