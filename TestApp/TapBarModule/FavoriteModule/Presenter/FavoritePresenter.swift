//
//  FavoritePresenter.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {

}

protocol FavoritePresenterProtocol: AnyObject{
    init(view: FavoriteViewProtocol, router: RouterProtocol)
    func goToDetailsModule()
}


class FavoritePresenter: FavoritePresenterProtocol {

    weak var view: FavoriteViewProtocol?
    let router: RouterProtocol?
    //var networkService: NetworkServiceProtocol!

    required init(view: FavoriteViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func goToDetailsModule() {
       // router?.showDetailsViewController()
    }
}
