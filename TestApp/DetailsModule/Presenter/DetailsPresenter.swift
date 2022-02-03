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
    init(view: DetailsViewProtocol, router: RouterProtocol, model: PhotoModel)
   
}


class DetailsPresenter: DetailsPresenterProtocol {

    weak var view: DetailsViewProtocol?
    let router: RouterProtocol?
    //var networkService: NetworkServiceProtocol!
    var model: PhotoModel?
    
    required init(view: DetailsViewProtocol, router: RouterProtocol, model: PhotoModel) {
        self.view = view
        self.router = router
        self.model = model
        print(model)
    }
}
