//
//  DetailsPresenter.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import Foundation

protocol DetailsViewProtocol: AnyObject {

}

protocol DetailsPresenterProtocol: AnyObject{
    init(view: DetailsViewProtocol, router: RouterProtocol)
   
}


class DetailsPresenter: DetailsPresenterProtocol {

    weak var view: DetailsViewProtocol?
    let router: RouterProtocol?
    //var networkService: NetworkServiceProtocol!

    required init(view: DetailsViewProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
    }
}
