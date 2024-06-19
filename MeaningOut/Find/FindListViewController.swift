//
//  FindListViewController.swift
//  MeaningOut
//
//  Created by 여누 on 6/17/24.
//

import UIKit
import SnapKit

class FindListViewController: UIViewController {
    let searchBar = UISearchBar()
    let mainView = UIView()
    let recentLabel = UILabel()
    let allRemove = UIButton()
    let tableView = UITableView()

    var itemList = UserDefaults.standard.array(forKey: "searchList")
    var page = 1
    var isend = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(itemList!)
        view.backgroundColor = .white
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        tableView.register(FindListTableViewCell.self, forCellReuseIdentifier: FindListTableViewCell.id)
        
        configureHierarchy()
        configureLayout()
    
        allRemove.addTarget(self, action: #selector(allRemoveClicked), for: .touchUpInside)
        

    }

    @objc func reloadTableView() {
        tableView.reloadData()
    }
    
    @objc func allRemoveClicked() {
        itemList?.removeAll()
        UserDefaults.standard.setValue(itemList, forKey: "searchList")
        tableView.reloadData()
        
//        let vc = FindViewController()
//        let nav = UINavigationController(rootViewController: vc)
//        nav.modalPresentationStyle = .fullScreen
//        present(nav, animated: true)
//        
//
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
//        let rootViewController = UINavigationController(rootViewController: FindViewController())
//        sceneDelegate?.window?.rootViewController = rootViewController
//        sceneDelegate?.window?.makeKeyAndVisible()
        
        
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
    
    func configureHierarchy() {
        
        view.addSubview(searchBar)
        view.addSubview(mainView)
        mainView.addSubview(recentLabel)
        mainView.addSubview(allRemove)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        searchBar.placeholder = "브랜드,상품 등을 입력하세요."
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(searchBar.safeAreaLayoutGuide)
            make.height.equalTo(60)
        }
        
        recentLabel.text = "최근 검색"
        recentLabel.textAlignment = .left
        recentLabel.font = .systemFont(ofSize: 15, weight: .black)
        recentLabel.snp.makeConstraints { make in
            make.top.equalTo(mainView.safeAreaLayoutGuide).inset(20)
            make.leading.equalTo(mainView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
        }
        
        allRemove.titleLabel?.font = .systemFont(ofSize: 13)
        allRemove.setTitle("전체 삭제", for: .normal)
        allRemove.setTitleColor(UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0), for: .normal)
        allRemove.snp.makeConstraints { make in
            make.top.equalTo(mainView.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(mainView.safeAreaLayoutGuide).offset(0)
            make.width.equalTo(55)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let afternick = UserDefaults.standard.string(forKey: "afternickname")
        if afternick != nil {
            navigationItem.title = "\(afternick!)'S MEANING OUT"
        }else {
            let nickName = UserDefaults.standard.string(forKey: "nickName")
            navigationItem.title = "\(nickName!)'S MEANING OUT"
        }
        
    }
    

}

extension FindListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        navigationController?.pushViewController(FindResultViewController(), animated: true)
        itemList?.insert(searchBar.text!, at: 0)
        UserDefaults.standard.setValue(searchBar.text!, forKey: "search")
        UserDefaults.standard.setValue(itemList, forKey: "searchList")
        tableView.reloadData()
    }
}

extension FindListViewController : UITableViewDelegate, UITableViewDataSource, FindListTableViewCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindListTableViewCell.id, for: indexPath) as! FindListTableViewCell
        let data = itemList![indexPath.row]
        UserDefaults.standard.setValue(indexPath.row, forKey: "indexPathrow")
        print("indexPathrowindexPathrowindexPathrowindexPathrow      \(indexPath.row)")
        cell.itemLabel.text = "\(data)"
        
        cell.xmarkButton.tag = indexPath.row
        cell.delegate = self
        
 
        return cell
    }
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindListTableViewCell.id, for: indexPath) as! FindListTableViewCell
        let data = itemList![indexPath.row]
        print("선택한 셀 : \(indexPath.row)")
        UserDefaults.standard.setValue(data, forKey: "search")
        navigationController?.pushViewController(FindResultViewController(), animated: true)
    }
    
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
////        print("Prefetch \(indexPaths)")
//        
//        for i in indexPaths {
//            if itemList!.count - 2 == i.row && isend == false{
//                print(itemList!.count)
//                page += 1
//                UserDefaults.standard.setValue(page, forKey: "page")
//            }
//        }
//    }
    // 취소기능 :단 직접 취소나는 기능을 주현을 해주어야한다.
//    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
////        print("Cancle Prefetch \(indexPaths)")
//    }
    
    func didTapXmarkButton(at index: Int) {
        itemList?.remove(at: index)
        tableView.reloadData()
    }
}


