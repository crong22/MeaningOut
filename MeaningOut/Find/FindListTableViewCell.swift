//
//  FindListTableViewCell.swift
//  MeaningOut
//
//  Created by 여누 on 6/17/24.
//

import UIKit


protocol FindListTableViewCellDelegate: AnyObject {
    func didTapXmarkButton(at index: Int)
}

class FindListTableViewCell: UITableViewCell {
    //clock xmark
    static let id = "FindListTableViewCell"
    
    let clockImage = UIImageView()
    let itemLabel = UILabel()
    let xmarkButton = UIButton()
    var searchitem = UserDefaults.standard.array(forKey: "searchList")
    //
    weak var delegate: FindListTableViewCellDelegate?
    //
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        
        xmarkButton.addTarget(self, action: #selector(xmarkButtonClicked), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        contentView.addSubview(clockImage)
        contentView.addSubview(itemLabel)
        contentView.addSubview(xmarkButton)
    }
    
    func configureLayout() {
        clockImage.image = UIImage(systemName: "clock")
        clockImage.tintColor = .black
        clockImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.width.equalTo(15)
        }
        
        itemLabel.font = .systemFont(ofSize: 13, weight: .medium)
        itemLabel.textColor = .black
        itemLabel.textAlignment = .left
        itemLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(9)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(45)
            make.height.equalTo(20)
        }
        
        xmarkButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xmarkButton.tintColor = .black
        xmarkButton.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).inset(11)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
            make.height.width.equalTo(14)
        }
    }

    @objc func xmarkButtonClicked(sender: UIButton) {
        print("X클릭")

        let row = UserDefaults.standard.integer(forKey: "indexPathrow")
        print("rowrowrowrowrowrowrowrow \(row)")
        searchitem?.remove(at: row)
        UserDefaults.standard.setValue(searchitem, forKey: "searchList")
        
        delegate?.didTapXmarkButton(at: sender.tag)
        
        print(searchitem!)

        if searchitem!.count < 1 {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let tabBarController = UITabBarController()
            
            tabBarController.tabBar.tintColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
            tabBarController.tabBar.unselectedItemTintColor = .gray
            
            let searchList = UserDefaults.standard.array(forKey: "searchList")!
            let FindViewController = FindViewController()
            let find = UINavigationController(rootViewController: FindViewController)
            find.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
            let SettingViewController = SettingViewController()
            let setting = UINavigationController(rootViewController: SettingViewController)
            setting.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
            
            tabBarController.setViewControllers([find, setting], animated: true)

            sceneDelegate?.window?.rootViewController = tabBarController // storyboard에서 entrypoint
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
