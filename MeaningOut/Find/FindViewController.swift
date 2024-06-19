//
//  FindViewController.swift
//  MeaningOut
//
//  Created by 여누 on 6/14/24.
//

import UIKit
import SnapKit

var searchList : [String] = []

class FindViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let imageView = UIImageView()
    let textLabel = UILabel()
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        view.addSubview(imageView)
        view.addSubview(textLabel)
        
        searchBar.placeholder = "브랜드,상품 등을 입력하세요."
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        
        imageView.image = UIImage(named: "empty")
        imageView.contentMode = .center
        imageView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(150)
        }
        
        textLabel.text = "최근 검색어가 없어요"
        textLabel.font = .systemFont(ofSize: 15, weight: .bold)
        textLabel.textAlignment = .center
        textLabel.textColor = .black
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let afternick = UserDefaults.standard.string(forKey: "afternickname")
        if afternick != nil {
            print("가입 한 상태")
            navigationItem.title = "\(afternick!)'S MEANING OUT"
        }else {
            let nickName = UserDefaults.standard.string(forKey: "nickName")
            print("처음 가입")
            navigationItem.title = "\(nickName!)'S MEANING OUT"
        }
    }

}

extension FindViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.pushViewController(FindResultViewController(), animated: true)
        searchList.removeAll()
        searchList.append(searchBar.text!)
        UserDefaults.standard.setValue(searchBar.text!, forKey: "search")
        UserDefaults.standard.setValue(searchList, forKey: "searchList")
        print("검색리스트 : \(searchList)")
        
        print(#function)
        page = 1
        
        
    }
}


