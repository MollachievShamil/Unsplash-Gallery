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
    func reloadCollectionView()
}

protocol MainPresenterProtocol: AnyObject{
    init(view: MainViewProtocol, router: RouterProtocol, networkService: NetworkServiceProtocol)
    func fetchPhotoModels()
    func goToDetailsModule(model: PhotoModel)
    func makeImage(img: Data?) -> UIImage
    var photoModels: [PhotoModel] {get set}
    func fetchSearchingPhotoModels(name: String)
    func addMorePhotoForInfinityScroll()
    func addMorePhotoForInfinityScrollWithSearching(name: String, page: Int)
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
    }
    
    //MARK: - Searching Photos
    func fetchSearchingPhotoModels(name: String){
        photoModels = []
        view?.reloadCollectionView()
        networkService?.fetchSearchingModelsOnPage(searchText: name, page: 1, completion: { [weak self] model in
            guard let model = model else { return }
            let photoModel = model.results
            self?.photoModels.append(contentsOf: photoModel)
            self?.getImages()
        })
    }
 

    func addMorePhotoForInfinityScrollWithSearching(name: String, page: Int){
        networkService?.fetchSearchingModelsOnPage(searchText: name, page: page, completion: { [weak self] model in
            guard let model = model else { return }
            let photoModel = model.results
            self?.photoModels.append(contentsOf: photoModel)
            self?.getImages()
        })
    }
    
    //MARK: - Random Photos
    func fetchPhotoModels() {
        photoModels = []
        view?.reloadCollectionView()
        networkService?.fetchModels { [weak self] model in
            guard let model = model else { return }
            self?.photoModels = model
            self?.getImages()
        }
    }
    
    func addMorePhotoForInfinityScroll() {
        networkService?.fetchModels { [weak self] model in
            guard let model = model else { return }
            self?.photoModels.append(contentsOf: model)
            self?.getImages()
        }
    }
    
    //MARK: - Fetching Photo data and Transform them in Images
    
    func makeImage(img: Data?) -> UIImage {
        guard let data = img else {
            return UIImage(systemName: "questionmark")!
        }
        if let image = UIImage(data: data) {
            return image
        }
        return UIImage(systemName: "questionmark")!
    }
    
    func getImages() {
        let dispatchGroup = DispatchGroup()
        for (index, picture) in photoModels.enumerated() {
            dispatchGroup.enter()
            networkService?.fetcImage(from: picture , response: { [weak self] data in
                if let data = data {
                    self?.photoModels[index].picture = data
                    dispatchGroup.leave()
                }
            })
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.view?.sucsess()
        }
    }
    
    //MARK: - Navigation
    func goToDetailsModule(model: PhotoModel) {
        router?.showDetailsViewController(models: model)
    }
}
