//
//  Router.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import UIKit

protocol RouterProtocol {
    func showDetailsViewController()
    func pop()
    var navigationController: UINavigationController { get set }
}

class Router: RouterProtocol {

    var navigationController: UINavigationController
    var assemblyBuilder: BuilderProtocol?

    func showDetailsViewController() {
        guard let componentViewController = assemblyBuilder?.createDetailsModule(router: self) else { return }
        navigationController.pushViewController(componentViewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    init(navigationController: UINavigationController, assemblyBuilder: BuilderProtocol) {
        self.assemblyBuilder = assemblyBuilder
        self.navigationController = navigationController
    }
}
