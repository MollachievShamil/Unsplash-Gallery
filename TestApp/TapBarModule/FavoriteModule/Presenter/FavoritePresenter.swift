//
//  FavoritePresenter.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import Foundation
import UIKit

protocol FavoriteViewProtocol: AnyObject {
    func sucsess()
}

protocol FavoritePresenterProtocol: AnyObject{
    init(view: FavoriteViewProtocol, router: RouterProtocol, realm: RealmServiceProtocol, networkService: NetworkServiceProtocol)
    func goToDetailsModule(ind: Int)
    func fetchName(index: Int) -> String
    func getNumresOfCells()-> Int
    func makeImage(ind: Int) -> UIImage
    var images: [Data] {get set}
    //func getImages()
}


class FavoritePresenter: FavoritePresenterProtocol {

    weak var view: FavoriteViewProtocol?
    let router: RouterProtocol?
    var realm: RealmServiceProtocol?
    var networkService: NetworkServiceProtocol?
    var images = [Data]()
    
    required init(view: FavoriteViewProtocol, router: RouterProtocol, realm: RealmServiceProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.realm = realm
        self.networkService = networkService
       // getImages()
    }
    
    func getNumresOfCells() -> Int {
        return realm?.picturesInRealm?.count ?? 0
    }
    
    func fetchName(index: Int) -> String {
        return realm?.picturesInRealm![index].name ?? " no name"
    }
    
    
   
    func makeImage(ind: Int) -> UIImage {
        let data = realm?.picturesInRealm![ind].pictureData
       
        guard let data = data else {
            return UIImage(systemName: "trash")!
        }
        if let image = UIImage(data: data) {
            return image
        }
        return UIImage(systemName: "trash")!
    }
    
//    func getImages() {
//        let dispatchGroup = DispatchGroup()
//        for i in realm!.picturesInRealm! {
//            dispatchGroup.enter()
//            networkService?.fetcRealmImage(from: i , response: { [weak self] data in
//                if let data = data {
//                    self?.images.append(data)
//                    dispatchGroup.leave()
//                }
//            })
//        }
//        dispatchGroup.notify(queue: DispatchQueue.main) {
//            self.view?.sucsess()
//    }
//}
    
    
    func goToDetailsModule(ind: Int){
        let realm = realm?.picturesInRealm![ind]
        let url = realm?.URL
        let created = realm?.createdAt
        let downloads = Int(realm!.downloads)
        let user = realm?.name
        let picture = Data(realm!.pictureData)
        let location = realm?.location
        
        let model = PhotoModel(urls: Urls(raw: nil, full: nil, regular: nil, small: url, thumb: nil), created_at: created, downloads: downloads, user: User(name: user, location: location), picture: picture)

        router?.showDetailsViewController(models: model)
    }
}
