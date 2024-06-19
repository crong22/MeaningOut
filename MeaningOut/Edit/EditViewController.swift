//
//  EditViewController.swift
//  MeaningOut
//
//  Created by 여누 on 6/17/24.
//

import UIKit
import SnapKit

class EditViewController: UIViewController {
    //    var rightBarButton : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: EditViewController.self, action: #selector(saveClicked))
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(rightButtonClicked))
        button.tag = 2
        return button
    }()
    
    var strData: String?
    var imageList = ["profile_0", "profile_1", "profile_2", "profile_3", "profile_4", "profile_5", "profile_6", "profile_7", "profile_8", "profile_9", "profile_10", "profile_11"]
    
    var imageButton = UIButton()
    let cameraImage = UIImageView()
    let nicknameTextField = UITextField()
    let warningLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "EDIT PROIFLE"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        
        navigationItem.rightBarButtonItem = rightButton
        
        configureHierarchy()
        configureLayout()
        
        
        imageButton.addTarget(self, action: #selector(imageButtonClicked), for: .touchUpInside)
        
        UserDefaults.standard.setValue(imageList, forKey: "imageList")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           // 이미지가 선택되었을 경우 설정
        if let selectedImage = UserDefaults.standard.string(forKey: "profileImage") {
            print(selectedImage)
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

//    func setNickname(_ nickName: String) {
//        var nickname = nickName
//        nicknameTextField.text = nickname
//    }
    @objc func rightButtonClicked(){
        print("세팅 저장하기")
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
            
            UserDefaults.standard.setValue(nicknameTextField.text!, forKey: "afternickname")
            let beforeImage = UserDefaults.standard.string(forKey: "profileImage")
            UserDefaults.standard.setValue(beforeImage, forKey: "profile")
            
           //navigationController?.pushViewController(SettingViewController(), animated: true)
            self.navigationController?.popViewController(animated: true)
      
        }
    }
    
    func configureHierarchy() {
        view.addSubview(imageButton)
        view.addSubview(cameraImage)
        view.addSubview(nicknameTextField)
        view.addSubview(warningLabel)
    }
    
    func configureLayout() {
//        let beforeImage = UserDefaults.standard.string(forKey: "profileImage")
        let profile = UserDefaults.standard.string(forKey: "profile")
        print("beforeImage : \(profile!)")
        imageButton.setImage(UIImage(named: profile!), for: .normal)
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
        let afternick = UserDefaults.standard.string(forKey: "afternickname")
        if afternick == nil {
            let beforenick = UserDefaults.standard.string(forKey: "nickName")
            nicknameTextField.text = beforenick!
        }else {
            nicknameTextField.text = afternick!
        }
        nicknameTextField.font = .systemFont(ofSize: 16, weight: .bold)
        nicknameTextField.textColor = .black
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(imageButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(35)
        }
        
        //닉네임관련안내문구
        warningLabel.textColor = .black
        warningLabel.font = .systemFont(ofSize: 12, weight: .bold)
        warningLabel.text = "사용 가능한 닉네임입니다 :D"
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(35)
            make.height.equalTo(40)
        }
    }
    
    @objc func imageButtonClicked(){
//        UserDefaults.standard.setValue(imageList[randomImage], forKey: "ranImage")
        print("Image버튼 클릭이다!!!")

        navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    
}
