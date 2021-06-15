//
//  SceneDelegate.swift
//  GitSearch
//
//  Created by Jacky Lao on 6/15/21.
///Users/jackylao/Documents/Direct PL/GitSearch/GitSearch

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = makeKeyWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
    }
}

extension SceneDelegate {
    private func makeKeyWindow(windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = makeNavigationController(rootViewController: makeRootViewController())
        return window
    }
    
    private func makeRootViewController() -> UIViewController {
        SearchViewController.instantiate()
    }
    
    private func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent = true
        return navigationController
    }
}
