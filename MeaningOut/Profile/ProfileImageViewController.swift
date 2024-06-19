//
//  ProfileImageViewController.swift
//  MeaningOut
//
//  Created by 여누 on 6/14/24.
//

import UIKit
import SnapKit

var subImage : [Int : String]  = [0 : "profile_0", 1 : "profile_1", 2 : "profile_2", 3 : "profile_3",  4 : "profile_4", 5 : "profile_5", 6 : "profile_6", 7 : "profile_7", 8 : "profile_8", 9 : "profile_9", 10 : "profile_10", 11 : "profile_11"]
 
let image = UserDefaults.standard.string(forKey: "profileImage")


class ProfileImageViewController: UIViewController {
    let profileImage = UIImageView()
    let cameraImage = UIImageView()
    let listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    let data = UserDefaults.standard.array(forKey: "imageList")
    let image = UserDefaults.standard.string(forKey: "profileImage")
    let backButton = UIBarItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "PROFILE SETTING"
        navigationController?.navigationBar.tintColor = .black
//        navigationController?.navigationBar.topItem?.title = ""
        let backBarButtonItem = UIBarButtonItem(image:UIImage(systemName: "chevron.backward") , style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
        
        view.addSubview(profileImage)
        view.addSubview(listCollectionView)
        view.addSubview(cameraImage)
        
        configuerLayOut()
    }
    

    @objc func backButtonClicked() {
        print(#function)
//        let preVC = ProfileViewController()
//        let imagedata = UserDefaults.standard.string(forKey: "profileImage")
//        
//        guard let vc = preVC as? ProfileViewController else { return }
//        vc.strData = imagedata
//        navigationController?.popViewController(animated: true)
        
        
        navigationController?.popViewController(animated: true)
    }
        
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 100
//        let height = UIScreen.main.bounds.height - 45
        
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }

    func configuerLayOut(){
        let imageTest = UserDefaults.standard.string(forKey:"profileImage")
        print("imageimage \(image!)")
        
        profileImage.image = UIImage(named: imageTest!)

        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 55
        profileImage.layer.borderWidth = 5
        profileImage.layer.borderColor = .init(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(140)
            make.height.width.equalTo(110)
        }
        
        cameraImage.image = UIImage(systemName: "camera.fill")
        cameraImage.backgroundColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
        cameraImage.contentMode = .center
        cameraImage.tintColor = .white
        cameraImage.layer.cornerRadius = 15
        cameraImage.snp.makeConstraints { make in
            make.bottom.equalTo(profileImage.snp.bottom)
            make.trailing.equalTo(profileImage)
            make.height.width.equalTo(30)
        }
        
        listCollectionView.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(300)
        }
    }
}

extension ProfileImageViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        let data = UserDefaults.standard.array(forKey: "imageList")
        let imagedata = UserDefaults.standard.string(forKey: "profileImage")
        let mainimage = UIImage(named: imagedata!)
        let image = UIImage(named: data![indexPath.item] as! String)
        cell.profileImage.image = image
        
        if imagedata == subImage[indexPath.row] {
            cell.profileImage.backgroundColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
            cell.profileImage.layer.borderWidth = 5
        }else {
            cell.profileImage.backgroundColor = UIColor(white: 100, alpha: 0.5)
            cell.profileImage.layer.borderWidth = 1
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as! ProfileImageCollectionViewCell
        let imageSelect = subImage[indexPath.item]!
        print("선택한 이미지 \(imageSelect)")
        UserDefaults.standard.setValue(imageSelect, forKey: "profileImage")
        UserDefaults.standard.setValue(imageSelect, forKey: "profileImageTest")
        cell.profileImage.backgroundColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)

        profileImage.image = UIImage(named: subImage[indexPath.item]!)
        listCollectionView.reloadData()

    }
}



