//
//  ProfileViewController.swift
//  MeaningOut
//
//  Created by 여누 on 6/14/24.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController{
    var mainView = UIView()
    var imageButton = UIButton()
    let cameraImage = UIImageView()
    let nicknameTextField = UITextField()
    let warningLabel = UILabel()
    let finishButton = UIButton()
    
    // 데이터를 받기 위해 변수를 생성해줘야 합니다.
    var strData: String?
    
    var imageList = ["profile_0", "profile_1", "profile_2", "profile_3", "profile_4", "profile_5", "profile_6", "profile_7", "profile_8", "profile_9", "profile_10", "profile_11"]
    let randomImage = Int.random(in: 0...11)
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        navigationItem.title = "PROFILE SETTING"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        view.addSubview(mainView)
        mainView.addSubview(imageButton)
        mainView.addSubview(cameraImage)
        mainView.addSubview(nicknameTextField)
        mainView.addSubview(warningLabel)
        mainView.addSubview(finishButton)

        configureLayout()
        imageButton.addTarget(self, action: #selector(imageButtonClicked), for: .touchUpInside)
        finishButton.addTarget(self, action: #selector(finishButtonClicked), for: .touchUpInside)
        
        UserDefaults.standard.setValue(imageList, forKey: "imageList")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           // 이미지가 선택되었을 경우 설정
        if let selectedImage = UserDefaults.standard.string(forKey: "profileImage") {
            setImage(selectedImage)
        }
       }

    func setImage(_ imageName: String) {
        if let image = UIImage(named: imageName) {
            imageButton.setImage(image, for: .normal)
        } else {
            print("이미지오류")
        }
    }
    
    func configureLayout() {
        //
        mainView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(0)
        }
        //프로필사진
        let collectionImage = strData
        
        if strData == nil {
            print("nil일 떄")
            imageButton.setImage(UIImage(named: imageList[randomImage]), for: .normal)
//            imageButton.setImage(UIImage(named: "\(strData ?? imageList[randomImage])"), for: .normal)
            UserDefaults.standard.setValue(imageList[randomImage], forKey: "profileImage")
        }else {
            print("nil아닐 때, strData \(strData!)")
            imageButton.setImage(UIImage(named:collectionImage!), for: .normal)
            UserDefaults.standard.setValue(strData, forKey: "profileImage")
        }
        imageButton.layer.masksToBounds = true
        imageButton.layer.cornerRadius = 55
        imageButton.layer.borderWidth = 5
        imageButton.layer.borderColor = .init(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        

        imageButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(140)
            make.height.width.equalTo(110)
        }
        
        //카메라이미지
        cameraImage.image = UIImage(systemName: "camera.fill")
        cameraImage.backgroundColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        cameraImage.contentMode = .center
        cameraImage.tintColor = .white
        cameraImage.layer.cornerRadius = 15
        cameraImage.snp.makeConstraints { make in
            make.bottom.equalTo(imageButton.snp.bottom)
            make.trailing.equalTo(imageButton)
            make.height.width.equalTo(30)
        }
        
        //닉네임 입력칸
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.font = .systemFont(ofSize: 16, weight: .bold)
        nicknameTextField.textColor = .black
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(35)
        }
        
        //닉네임관련안내문구
        warningLabel.textColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        warningLabel.font = .systemFont(ofSize: 12, weight: .bold)
        warningLabel.text = ""
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(35)
            make.height.equalTo(40)
        }
        
        //완료버튼
        finishButton.backgroundColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        finishButton.layer.cornerRadius = 20
        finishButton.setTitle("완료", for: .normal)
        finishButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp.top).offset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
    }

    
    @objc func imageButtonClicked(){
//        UserDefaults.standard.setValue(imageList[randomImage], forKey: "ranImage")
        navigationController?.pushViewController(ProfileImageViewController(), animated: true)
    }
    
    @objc func finishButtonClicked(){
        let wordList = ["@","#","$","%"]
        let numList = [0,1,2,3,4,5,6,7,8,9]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let join = formatter.string(from: Date())
        UserDefaults.standard.setValue(join, forKey: "joindate")
        
        UserDefaults.standard.set(true, forKey: "isUser")
        
        if nicknameTextField.text!.count > 1 && nicknameTextField.text!.count < 10 {
            for _char in nicknameTextField.text! {
                for num in numList {
//                    print("char: \(String(_char)), num \(String(num))")
                    if String(_char) == String(num) {
                        warningLabel.text = "닉네임에 숫자는 포함할 수 없어요"
                        return
                    }
                }
            }
            warningLabel.text = "사용할 수 있는 닉네임이에요 :)"
            
            UserDefaults.standard.setValue(nicknameTextField.text!, forKey: "nickName")
            UserDefaults.standard.setValue(randomImage, forKey: "profileMainImage")
            var image = UserDefaults.standard.string(forKey: "profileImage")
            UserDefaults.standard.setValue(image, forKey: "profile")
            
            print("가입할 떄 입력한 닉네임 : \(UserDefaults.standard.string(forKey: "nickName"))")
            print("가입할 떄 입력한 이미지 : \(UserDefaults.standard.string(forKey: "profile"))")
            /*
            let vc = FindViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
            
            // rootViewController를 사용하여 기존에 쌓인 뷰를 삭제하여 처음상태로 돌려준다.
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            
            let rootViewController = UINavigationController(rootViewController: FindViewController())
            
            sceneDelegate?.window?.rootViewController = rootViewController // storyboard에서 entrypoint
            sceneDelegate?.window?.makeKeyAndVisible()     // show
            */
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
            
            
        }else if nicknameTextField.text!.count < 1 || nicknameTextField.text!.count < 9 {
            for word in 0...3 {
                if nicknameTextField.text! == wordList[word] {
                    warningLabel.text = "닉네임에 @,#,$,%는 포함할 수 없어요."
                    return
                }else {
                    warningLabel.text = "2글자 이상 10글자 미만으로 설정해주세요."
                }
            }
        }else {
        
        }
    }
    

}
