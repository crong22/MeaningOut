//  FindResultViewController.swift
//  MeaningOut
//
//  Created by 여누 on 6/15/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class FindResultViewController: UIViewController {
    let mainView = UIView()
    let findCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let resultLabel = UILabel()
    let accuracyButton = UIButton()
    let dateButton = UIButton()
    let highPriceButton = UIButton()
    let lowPriceButton = UIButton()
    var search = UserDefaults.standard.string(forKey: "search")
    var page = 1
    var isLoading = false
    var isEnd = false
    var list = Naver(total: 0, start: 0, display: 0, items: [])
    var likedItems: [String: Bool] = [:]
    var itemList = UserDefaults.standard.array(forKey: "searchList")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "\(search!)"
        navigationController?.navigationBar.tintColor = .black
        let backBarButtonItem = UIBarButtonItem(image:UIImage(systemName: "chevron.backward") , style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backBarButtonItem
        print("검색하는 품목 : \(search!)")
        callRequest(query: search!, sort : "sim")
        configureHierarchy()
        configureLayout()
        
        accuracyButton.backgroundColor = .darkGray
        accuracyButton.setTitleColor(.white, for: .normal)
        
        accuracyButton.addTarget(self, action: #selector(accuracyButtonClicked), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateButtonClicked), for: .touchUpInside)
        highPriceButton.addTarget(self, action: #selector(highPriceButtonClicked), for: .touchUpInside)
        lowPriceButton.addTarget(self, action: #selector(lowPriceButtonClicked), for: .touchUpInside)
        
        //
        NotificationCenter.default.addObserver(self, selector: #selector(handleLikeButtonTapped(_:)), name: NSNotification.Name("likeButtonTapped"), object: nil)
        
        loadLikedItems()
        //
        
        findCollectionView.delegate = self
        findCollectionView.dataSource = self
        findCollectionView.isPrefetchingEnabled = true
        findCollectionView.prefetchDataSource = self
        findCollectionView.register(FindResultCollectionViewCell.self, forCellWithReuseIdentifier: FindResultCollectionViewCell.id)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("likeButtonTapped"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UserDefaults에서 좋아요 상태 가져오기
        let isLiked = UserDefaults.standard.bool(forKey: "isLiked")
        print("라이크 \(isLiked)")
        
        // 컬렉션 뷰 데이터 다시 로드
        findCollectionView.reloadData()
        
        // 좋아요 상태가 true인 항목 개수 출력
        let likedItemCount = likedItems.values.filter { $0 == true }.count
        print("좋아요가 true인 항목의 개수: \(likedItemCount)")
        UserDefaults.standard.setValue(likedItemCount, forKey: "totalLike")
        print("222 \(UserDefaults.standard.integer(forKey: "totalLike"))")
    }

    //
    @objc func backButtonClicked() {
        print("뒤로")
        let searchList = UserDefaults.standard.array(forKey: "searchList")
        if searchList != nil {

            self.navigationController?.popViewController(animated: true)

            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let tabBarController = UITabBarController()
            
            tabBarController.tabBar.tintColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
            tabBarController.tabBar.unselectedItemTintColor = .gray
            
            let searchList = UserDefaults.standard.array(forKey: "searchList")!
            let FindViewController = FindListViewController()
            let find = UINavigationController(rootViewController: FindViewController)
            find.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
            let SettingViewController = SettingViewController()
            let setting = UINavigationController(rootViewController: SettingViewController)
            setting.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
            
            tabBarController.setViewControllers([find, setting], animated: true)

            sceneDelegate?.window?.rootViewController = tabBarController
        }else {

            self.navigationController?.popViewController(animated: true)

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

            sceneDelegate?.window?.rootViewController = tabBarController
        }
        
    }
    //
    @objc func accuracyButtonClicked() {
        let itemsearch = UserDefaults.standard.string(forKey: "search")
        print(#function)
        accuracyButton.backgroundColor = .darkGray
        accuracyButton.setTitleColor(.white, for: .normal)
        dateButton.backgroundColor = .white
        dateButton.setTitleColor(.darkGray, for: .normal)
        highPriceButton.backgroundColor = .white
        highPriceButton.setTitleColor(.darkGray, for: .normal)
        lowPriceButton.backgroundColor = .white
        lowPriceButton.setTitleColor(.darkGray, for: .normal)
        //
        page = 1
        isEnd = false
        //
        callRequest(query: itemsearch!, sort : "sim")
    }
    
    @objc func dateButtonClicked() {
        print(#function)
        let itemsearch = UserDefaults.standard.string(forKey: "search")
        dateButton.backgroundColor = .darkGray
        dateButton.setTitleColor(.white, for: .normal)
        accuracyButton.backgroundColor = .white
        accuracyButton.setTitleColor(.darkGray, for: .normal)
        highPriceButton.backgroundColor = .white
        highPriceButton.setTitleColor(.darkGray, for: .normal)
        lowPriceButton.backgroundColor = .white
        lowPriceButton.setTitleColor(.darkGray, for: .normal)
        //
        page = 1
        isEnd = false
        //
        callRequest(query: itemsearch!, sort : "date")
    }
    
    @objc func highPriceButtonClicked() {
        print(#function)
        let itemsearch = UserDefaults.standard.string(forKey: "search")
        highPriceButton.backgroundColor = .darkGray
        highPriceButton.setTitleColor(.white, for: .normal)
        accuracyButton.backgroundColor = .white
        accuracyButton.setTitleColor(.darkGray, for: .normal)
        dateButton.backgroundColor = .white
        dateButton.setTitleColor(.darkGray, for: .normal)
        lowPriceButton.backgroundColor = .white
        lowPriceButton.setTitleColor(.darkGray, for: .normal)
        //
        page = 1
        isEnd = false
        //
        callRequest(query: itemsearch!, sort : "dsc")
    }
    
    @objc func lowPriceButtonClicked() {
        print(#function)
        let itemsearch = UserDefaults.standard.string(forKey: "search")
        lowPriceButton.backgroundColor = .darkGray
        lowPriceButton.setTitleColor(.white, for: .normal)
        accuracyButton.backgroundColor = .white
        accuracyButton.setTitleColor(.darkGray, for: .normal)
        dateButton.backgroundColor = .white
        dateButton.setTitleColor(.darkGray, for: .normal)
        highPriceButton.backgroundColor = .white
        highPriceButton.setTitleColor(.darkGray, for: .normal)
        //
        page = 1
        isEnd = false
        //
        callRequest(query: itemsearch!, sort : "asc")
    }
    
    func configureHierarchy() {
        view.addSubview(mainView)
        view.addSubview(findCollectionView)
        
        mainView.addSubview(resultLabel)
        mainView.addSubview(accuracyButton)
        mainView.addSubview(dateButton)
        mainView.addSubview(highPriceButton)
        mainView.addSubview(lowPriceButton)
        
        
    }
    
    func configureLayout(){
        let totalCnt = list.total
        // 검색결과 0이 나오는 조건의 경우
        if totalCnt < 1 {
            resultLabel.text = "검색결과 없습니다."
            hiddenButton()
        }
        
        mainView.backgroundColor = .white
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(90)
        }
        print(list.total)
        

        resultLabel.font = .systemFont(ofSize: 15, weight: .black)
        resultLabel.textColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        resultLabel.textAlignment = .left
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(mainView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(mainView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
        }
        

        accuracyButton.backgroundColor = .white
        accuracyButton.layer.borderWidth = 1
        accuracyButton.setTitle("정확도", for: .normal)
        accuracyButton.setTitleColor(.darkGray, for: .normal)
        accuracyButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        accuracyButton.layer.cornerRadius = 15
        accuracyButton.clipsToBounds = true
        accuracyButton.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
            make.leading.equalTo(mainView.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        
        dateButton.backgroundColor = .white
        dateButton.layer.borderWidth = 1
        dateButton.setTitle("날짜순", for: .normal)
        dateButton.setTitleColor(.darkGray, for: .normal)
        dateButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        dateButton.layer.cornerRadius = 15
        dateButton.clipsToBounds = true
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        
        highPriceButton.backgroundColor = .white
        highPriceButton.layer.borderWidth = 1
        highPriceButton.setTitle("가격높은순", for: .normal)
        highPriceButton.setTitleColor(.darkGray, for: .normal)
        highPriceButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        highPriceButton.layer.cornerRadius = 15
        highPriceButton.clipsToBounds = true
        highPriceButton.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(150)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        lowPriceButton.backgroundColor = .white
        lowPriceButton.layer.borderWidth = 1
        lowPriceButton.setTitle("가격낮은순", for: .normal)
        lowPriceButton.setTitleColor(.darkGray, for: .normal)
        lowPriceButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        lowPriceButton.layer.cornerRadius = 15
        lowPriceButton.clipsToBounds = true
        lowPriceButton.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(240)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        findCollectionView.backgroundColor = .white
        findCollectionView.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 45
        let height = UIScreen.main.bounds.height - 300
        
        layout.itemSize = CGSize(width: width/2, height: height/2)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 19, right: 10)
        return layout
    }
    
    func callRequest(query : String, sort : String) {
        print(#function)
        isLoading = true
        let url = "https://openapi.naver.com/v1/search/shop.json?"
        let header : HTTPHeaders = ["X-Naver-Client-Id" : APIKey.naverID , "X-Naver-Client-Secret" : APIKey.naverSecret ]
        print(url)
        let param : Parameters = ["query" : query, "sort" : sort , "display" : 30]
        AF.request(url,
                   method: .get,
                   parameters: param,
                   headers: header)
        .responseDecodable(of: Naver.self) { [self] response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                print("page \(page)")
                if value.items.isEmpty {
                    print("ISEND")
                    self.isEnd = true
                }
                if page == 1 {
                    self.list = value
                    UserDefaults.standard.setValue(self.list.total, forKey: "totalitem")
                    self.list.items = self.list.items.map {
                        var item = $0
                        item.like = self.likedItems[item.title] ?? false
                        return item
                    }
                }else {
                    var newItems = value.items
                    newItems = newItems.map {
                        var item = $0
                        item.like = self.likedItems[item.title] ?? false
                        return item
                    }
                    self.list.items.append(contentsOf: value.items)

                }
                
                let numberFormatter: NumberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let total = UserDefaults.standard.integer(forKey: "totalitem")
                let result: String = numberFormatter.string(for: total)!
                resultLabel.text = "\(result)개의 검색 결과"
                
                self.findCollectionView.reloadData()
 
                if page == 1 {
                    if self.list.total > 1 {
                        findCollectionView.scrollToItem(at: IndexPath(row:0, section: 0), at: .top, animated: false)
                    }
                }
                
                case .failure(let error):
                print(error)
            }
            self.isLoading = false
        }
    }
    
    @objc func handleLikeButtonTapped(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [String: Any],
           let indexPath = userInfo["indexPath"] as? IndexPath,
           let isLiked = userInfo["isLiked"] as? Bool {
            likedItems[list.items[indexPath.row].title] = isLiked
            list.items[indexPath.row].like = isLiked 
            saveLikedItems()
            findCollectionView.reloadItems(at: [indexPath])
        }
    }

    func saveLikedItems() {
        let likedItemsData = try? JSONEncoder().encode(likedItems)
        UserDefaults.standard.set(likedItemsData, forKey: "likedItems")
    }

    func loadLikedItems() {
        if let savedLikedItemsData = UserDefaults.standard.data(forKey: "likedItems"),
           let savedLikedItems = try? JSONDecoder().decode([String: Bool].self, from: savedLikedItemsData) {
            likedItems = savedLikedItems
        }
    }
    
    func hiddenButton() {
        accuracyButton.isHidden = true
        dateButton.isHidden = true
        highPriceButton.isHidden = true
        lowPriceButton.isHidden = true
    }
}



extension FindResultViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(list.items.count)
        return list.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindResultCollectionViewCell.id, for: indexPath) as! FindResultCollectionViewCell
        let data = list.items[indexPath.item]
        let imageURL = URL(string: data.image)
        cell.imageView.kf.setImage(with: imageURL)
        cell.storeLabel.text = data.mallName
        var titletext = data.title
        titletext = titletext.replacingOccurrences(of: "<b>", with: " ")
        titletext = titletext.replacingOccurrences(of: "</b>", with: " ")
        
        var title = data.title.replacingOccurrences(of: "<b>\(search!)</b>",with: "\(search!)", options: .regularExpression)
        
        cell.titleLabel.text = titletext
        UserDefaults.standard.setValue(title, forKey: "title")
        
        
        
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result: String = numberFormatter.string(for: Int(data.lprice))!
        cell.priceLabel.text = "\(result)원"
        
        let item = list.items[indexPath.row]
        cell.configure(with: item)
        cell.indexPath = indexPath
        cell.delegate = self

        let isLiked2 = UserDefaults.standard.bool(forKey: "isLiked")
        print("isliked2 \(isLiked2)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindResultCollectionViewCell.id, for: indexPath) as! FindResultCollectionViewCell
        let data = list.items[indexPath.item]
        let vc = DetailViewController()
        vc.item = data
        vc.indexPath = indexPath
        vc.isLiked = data.like
        
        //추가적으로 전달 ..
        let islike2 = UserDefaults.standard.bool(forKey: "isLiked2")
        
        UserDefaults.standard.setValue(vc.isLiked, forKey: "islike")
        
        UserDefaults.standard.setValue(data.link, forKey: "link")
        print("전달하는 값 : \(UserDefaults.standard.bool(forKey: "islike"))")
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
}

extension FindResultViewController : UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for i in indexPaths {
            if list.items.count - 2 == i.row {
                page += 1
                callRequest(query: search!, sort : "sim")
            }
        }
    }
}

extension FindResultViewController: FindResultCollectionViewCellDelegate {
    func didTapLikeButton(at indexPath: IndexPath, item: NaverInfo) {
        likedItems[item.title] = item.like
        saveLikedItems()
    }
}
