//
//  MainPresenter.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {

}

protocol MainPresenterProtocol: AnyObject{
    init(view: MainViewProtocol, router: RouterProtocol)
   
}


class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    let router: RouterProtocol?
    var networkService: NetworkServiceProtocol!

    required init(view: MainViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
