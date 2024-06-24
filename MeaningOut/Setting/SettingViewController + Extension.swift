//
//  SettingViewController + Extension.swift
//  MeaningOut
//
//  Created by 여누 on 6/24/24.
//
import UIKit

extension SettingViewController {
    func settingAlert(title : String, message : String, completionHandler : @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        let check = UIAlertAction(title: "확인", style: .default) {_ in
            completionHandler()
        }
        
        alert.addAction(cancle)
        alert.addAction(check)
        
        present(alert, animated: true)
    }
}
