//
//  Assembly.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createDetailsModule(router: RouterProtocol) -> UIViewController
    func createTabBar() -> UITabBarController
}

class ModuleBuilder: BuilderProtocol {
    
   // var navigationController: UINavigationController?
    
   //var assemblyBuilder: BuilderProtocol?

    private func createMainViewControllerModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let navigationController = createNavigationViewController(controller: view, title: "Random Images", image: UIImage(systemName: "house.fill"))
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        let presenter = MainPresenter(view: view, router: router)
        presenter.networkService = networkService
        view.presenter = presenter
        return navigationController
    }
    
    
    private func createFavoriteControllerModule() -> UIViewController {
        let view = FavoriteViewController()
       // let networkService = NetworkService()
        //let dataStoreManager = CoreDataManager()
        let navigationController = createNavigationViewController(controller: view, title: "Favorite", image: UIImage(systemName: "heart.fill"))
        let router = Router(navigationController: navigationController, assemblyBuilder: self)
        let presenter = FavoritePresenter(view: view, router: router)
        view.presenter = presenter
        return navigationController
    }
    
    func createDetailsModule(router: RouterProtocol) -> UIViewController {
        let view = DetailsViewController()
       // let networkService = NetWorkService()
       // let dataStoreManager = CoreDataManager()
        let presenter = DetailsPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    private func createNavigationViewController(controller: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller)
        controller.title = title
        controller.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemYellow]
        navigationController.navigationBar.barTintColor = .lightGray
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
        return navigationController
    }
}

extension ModuleBuilder {
    
    func createTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()
        
        let mainViewController = createMainViewControllerModule()
        let favoriteViewController = createFavoriteControllerModule()
        
        tabBarController.viewControllers = [mainViewController, favoriteViewController]
        tabBarController.tabBar.tintColor = .systemYellow
        tabBarController.tabBar.barTintColor = .lightGray
        return tabBarController
    }
}
