//
//  MainPresenter.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {

}

protocol MainPresenterProtocol: AnyObject{
    init(view: MainViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol)
    func getPhotoInformation()
    func goToDetailsModule()
}


class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    let router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    
    var pictureInformation: [PhotoModel]?
    var picturesArray: [UIImage]?
    
    required init(view: MainViewProtocol, router: RouterProtocol,networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        getPhotoInformation()
    }
    
    func getPhotoInformation() {
        networkService?.fetchRandomImage { aa in
            self.pictureInformation = aa
           // print(aa)
                 self.getImages()
        }
    }
    
    func getImages() {
        guard let pictureInformation = pictureInformation else {return}
        
        for (index, picture) in pictureInformation.enumerated() {
            networkService?.fetcImage(from: picture , response: { image in
                self.picturesArray?.append(image)
                print(image)
            })
        }
        print(picturesArray)
    }
    
  
    func goToDetailsModule() {
        router?.showDetailsViewController()
    }
}
