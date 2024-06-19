//
//  SettingViewController.swift
//  MeaningOut
//
//  Created by 여누 on 6/16/24.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {
    let mainvView = UIView()
    let tableView = UITableView()
    
    let mainTitle = UILabel()
    var isUser = true
    let profileImage = UIButton()
    let nickname = UILabel()
    let joindate = UILabel()
    let nextButton = UIButton()
    let mainButton = UIButton()
    
    let textList = ["나의 장바구니 목록", "자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("SettingViewController")
        navigationItem.title = "SETTING"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id) 
        configureHierarchy()
        configureLayout()
        
        mainButton.addTarget(self, action: #selector(mainButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "SETTING"
        if let selectedImage = UserDefaults.standard.string(forKey: "profileImage") {
            setImage(selectedImage)
        }
        let afternick = UserDefaults.standard.string(forKey: "afternickname")
        if afternick != nil {
            nickname.text = afternick
        }
       }
    
    func setImage(_ imageName: String) {
        if let image = UIImage(named: imageName) {
            profileImage.setImage(image, for: .normal)
        } else {
            print("이미지오류")
        }
    }
    
    @objc func mainButtonClicked() {
        print("프로필 수정 클릭")
        let profile = UserDefaults.standard.string(forKey: "selectprofile")
        UserDefaults.standard.setValue(profile, forKey: "profile")
        navigationController?.pushViewController(EditViewController(), animated: true)
    }
    
    func configureHierarchy() {
        view.addSubview(mainvView)
        view.addSubview(tableView)
        view.addSubview(mainTitle)
        
        mainvView.addSubview(mainButton)
        mainvView.addSubview(profileImage)
        mainvView.addSubview(nickname)
        mainvView.addSubview(joindate)
        mainvView.addSubview(nextButton)
    }
    
    func configureLayout() {

        mainvView.backgroundColor = .white
        mainvView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
        }
        
        mainButton.snp.makeConstraints { make in
            make.edges.equalTo(mainvView.safeAreaLayoutGuide)
        }
        
//        let profile = UserDefaults.standard.string(forKey: "profileImage")
        let profile = UserDefaults.standard.string(forKey: "selectprofile")
//        profileImage.setImage(UIImage(named: profile!), for: .normal) profile_0
        profileImage.setImage(UIImage(named: profile!), for: .normal)
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 40
        profileImage.layer.borderWidth = 5
        profileImage.layer.borderColor = .init(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(mainvView.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(mainvView.safeAreaLayoutGuide).inset(15)
            make.height.width.equalTo(80)
            
        }
        
        let nick = UserDefaults.standard.string(forKey: "nickName")

        nickname.text = nick!
        nickname.font = .systemFont(ofSize: 18, weight: .bold)
        nickname.textColor = .black
        nickname.textAlignment = .left
        nickname.snp.makeConstraints { make in
            make.top.equalTo(mainvView.safeAreaLayoutGuide).inset(45)
            make.leading.equalTo(profileImage.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(30)
        }
        
        var join = UserDefaults.standard.string(forKey: "joindate")
        join = join!.replacingOccurrences(of: "-",with: ". ", options: .regularExpression)
        joindate.text = "\(join!) 가입"
        joindate.textColor = .gray
        joindate.textAlignment = .left
        joindate.font = .systemFont(ofSize: 12, weight: .regular)
        joindate.snp.makeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).inset(5)
            make.leading.equalTo(profileImage.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(20)
        }
        
        nextButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        nextButton.contentMode = .scaleAspectFill
        nextButton.tintColor = .gray
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(mainvView.safeAreaLayoutGuide).inset(37)
            make.trailing.equalTo(mainvView.safeAreaLayoutGuide).inset(15)
            make.height.width.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(mainvView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
    }

}

extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as! SettingTableViewCell
        cell.listLabel.text = textList[indexPath.row]
        if indexPath.row == 0 {
            cell.likeImage.image = UIImage(named: "like_selected")

            let fontSize = UIFont.systemFont(ofSize: 15, weight: .heavy)
            
            let countnum = UserDefaults.standard.integer(forKey: "totalLike")
            cell.likeLabel.text = "\(countnum)개의 상품"
            let attributedStr = NSMutableAttributedString(string: cell.likeLabel.text!)

            attributedStr.addAttribute(.font, value: fontSize, range: (cell.likeLabel.text! as NSString).range(of: "\(countnum)개"))
            
            cell.likeLabel.attributedText = attributedStr
            
        }
//        print(textList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if indexPath.row ==  4 {
            print("세팅에서 선택한 셀 \(textList[indexPath.row])")
            UserDefaults.standard.setValue(false, forKey: "isUser")
            UserDefaults.standard.setValue(nil, forKey: "afternickname")
            isUser = false
            let vc = MainViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let rootViewController = UINavigationController(rootViewController: MainViewController())
            
            sceneDelegate?.window?.rootViewController = rootViewController // storyboard에서 entrypoint
            sceneDelegate?.window?.makeKeyAndVisible()     // show
        }
    }
}
    