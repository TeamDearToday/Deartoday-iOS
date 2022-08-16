//
//  SceneDelegate.swift
//  Deartoday
//
//  Created by 소연 on 2022/07/06.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let scene = (scene as? UIWindowScene) else { return }
//        self.window = UIWindow(windowScene: scene)
//        self.window?.rootViewController = SplashViewController()
//        self.window?.makeKeyAndVisible()
    
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

