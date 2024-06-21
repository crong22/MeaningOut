//
//  SceneDelegate.swift
//  MeaningOut
//
//  Created by 여누 on 6/14/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        
    

        let data = UserDefaults.standard.bool(forKey: "isUser")
        print(data)
        
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        
        if data {
            let tabBarController = UITabBarController()
            
            tabBarController.tabBar.tintColor = UIColor(red: 0.9373, green: 0.5373, blue: 0.2784, alpha: 1.0)
            tabBarController.tabBar.unselectedItemTintColor = .gray
            
            //가입 후, 앱 재실행 시 런타임 오류 수정
            var searchList = UserDefaults.standard.array(forKey: "searchList") ?? []
            
            print("SceneDelegate searchList : \(searchList)")
            
            if searchList.count < 1 {
                let FindViewController = FindViewController()
                let find = UINavigationController(rootViewController: FindViewController)
                find.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
                let SettingViewController = SettingViewController()
                let setting = UINavigationController(rootViewController: SettingViewController)
                setting.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
                
                tabBarController.setViewControllers([find, setting], animated: true)

                window?.rootViewController = tabBarController // storyboard에서 entrypoint
            }else {
                let FindListViewController = FindListViewController() // FindListViewController
                let find = UINavigationController(rootViewController: FindListViewController)
                find.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
                let SettingViewController = SettingViewController()
                let setting = UINavigationController(rootViewController: SettingViewController)
                setting.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
                
                tabBarController.setViewControllers([find, setting], animated: true)

                window?.rootViewController = tabBarController // storyboard에서 entrypoint
            }
        }else {
            print("MainViewController")
            let rootViewController = UINavigationController(rootViewController: MainViewController())
            
            window?.rootViewController = rootViewController // storyboard에서 entrypoint
        }
        window?.makeKeyAndVisible()     // show
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

