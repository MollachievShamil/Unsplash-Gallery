//
//  MainPresenter.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func sucsess()
}

protocol MainPresenterProtocol: AnyObject{
    init(view: MainViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol)
    func getPhotoInformation()
    func goToDetailsModule()
    func makeImage(img: Data?) -> UIImage
    var photoModels: [PhotoModel] {get set}
}


class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    let router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    
    var photoModels: [PhotoModel] = []

    
    required init(view: MainViewProtocol, router: RouterProtocol,networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        getPhotoInformation()
    }
    
    func getPhotoInformation() {
        networkService?.fetchModels { model in
            guard let model = model else { return }
            self.photoModels = model
            self.getImages()
        }
    }
    
    func makeImage(img: Data?) -> UIImage {
        guard let data = img else {
            return UIImage(systemName: "trash")!
        }
        if let image = UIImage(data: data) {
            return image
        }
        return UIImage(systemName: "trash")!
    }
    
    func getImages() {
        let dispatchGroup = DispatchGroup()
        for (index, picture) in photoModels.enumerated() {
            dispatchGroup.enter()
            networkService?.fetcImage(from: picture , response: { data in
                if let data = data {
                    self.photoModels[index].picture = data
                    dispatchGroup.leave()
                }
            })
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.view?.sucsess()
    }
    }
  
    func goToDetailsModule() {
        router?.showDetailsViewController()
    }
}
