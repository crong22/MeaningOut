//
//  DetailViewController.swift
//  MeaningOut
//
//  Created by 여누 on 6/16/24.
//

import UIKit
import WebKit
import SnapKit


class DetailViewController: UIViewController {
    let webView = WKWebView()
    var item: NaverInfo?
    var indexPath: IndexPath?
    var isLiked: Bool = false {
        didSet {
            updateLikeButton()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // 초기 isLiked 값을 UserDefaults에서 불러오기
        isLiked = UserDefaults.standard.bool(forKey: "islike")
        
        print("isLikedisLikedisLikedisLiked \(isLiked)")
        
        // 좋아요 버튼 설정
        let likeButtonImage = isLiked ? "like_selected" : "like_unselected"
        let likeButton = UIBarButtonItem(image: UIImage(named: likeButtonImage), style: .plain, target: self, action: #selector(toggleLike))
        navigationItem.rightBarButtonItem = likeButton
        likeButton.tintColor = .black
        
        updateLikeButton()
        
        let title = UserDefaults.standard.string(forKey: "title")
        navigationItem.title = "\(title!)"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        //webView start
        let link = UserDefaults.standard.string(forKey: "link")
        let url = URL(string: link!)
        let request = URLRequest(url: url! )
        webView.load(request)
        //webView end
        
        view.addSubview(webView)
        configureLayout()
    }
    
//    @objc func toggleLike() {
//        isLiked.toggle()
//        print("isLiked \(isLiked)")
////        UserDefaults.standard.setValue(isLiked, forKey: "isLiked")
//        if let indexPath = indexPath {
//            print("1111111111113131311313")
//            UserDefaults.standard.set(isLiked, forKey: "isLiked_\(indexPath.row)")
//            print("toggleLike detail")
//            NotificationCenter.default.post(name: NSNotification.Name("likeButtonTapped"), object: nil, userInfo: ["indexPath": indexPath, "isLiked": isLiked])
//        
//        }
//    }
    
    @objc func toggleLike() {
        isLiked.toggle()
        UserDefaults.standard.set(isLiked, forKey: "isLiked2")
        if let indexPath = indexPath {
            UserDefaults.standard.set(isLiked, forKey: "isLiked_\(indexPath.row)")
        }

    }
    
    func updateLikeButton() {
        print("업데이트")
        let imageName = isLiked ? "like_selected" : "like_unselected"
        navigationItem.rightBarButtonItem?.image = UIImage(named: imageName)
    }
    
    func configureLayout() {
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
