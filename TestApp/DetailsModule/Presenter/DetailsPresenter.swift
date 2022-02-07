//
//  DetailsPresenter.swift
//  TestApp
//
//  Created by Шамиль Моллачиев on 02.02.2022.
//

import Foundation
import UIKit

protocol DetailsViewProtocol: AnyObject {
    func setUpPhoto(image: UIImage)
}

protocol DetailsPresenterProtocol: AnyObject{
    init(view: DetailsViewProtocol, router: RouterProtocol, model: PhotoModel, networkService: NetworkServiceProtocol, realm: RealmServiceProtocol)
    var model: PhotoModel? {get set}
    func getNameLabel() -> String
    func getDateOfCreationLabel() -> String
    func getLocationLabel() -> String
    func getDownloadsLabel() -> String
    func downloadPhoto()
    func getData() -> Data
    func saveDeleteFromRealm(model: RealmPictureModel)
    func getURL() -> String
    func imageExistInRealm(model: RealmPictureModel) -> Bool
}


class DetailsPresenter: DetailsPresenterProtocol {
  
    weak var view: DetailsViewProtocol?
    let router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    var model: PhotoModel?
    var realm: RealmServiceProtocol?
    
    required init(view: DetailsViewProtocol, router: RouterProtocol, model: PhotoModel, networkService: NetworkServiceProtocol, realm: RealmServiceProtocol) {
        self.view = view
        self.router = router
        self.model = model
        self.networkService = networkService
        self.realm = realm
        downloadPhoto()
    }
    
    //MARK: - Work With Realm
    func imageExistInRealm(model: RealmPictureModel) -> Bool{
        return realm!.imageExistInRealm(model: model)
    }
    
    func saveDeleteFromRealm(model: RealmPictureModel) {
        realm?.saveDelete(picture: model)
    }
    
    //MARK: - set lables
    func getURL() -> String {
        let item = model?.urls?.small
        if let item = item {
            return item
        } else {
            return " .......... "
        }
    }

    func getData() -> Data {
        let item = model?.picture
        if let item = item {
            return item
        }
        return Data()
    }
    
    func getNameLabel() -> String {
        let item = model?.user?.name
        if let item = item {
            return item
        } else {
            return " .......... "
        }
    }
    
    func getDateOfCreationLabel() -> String {
        let item = model?.created_at
        if let item = item {
            let formattedDate = setDateFormat(date: item)
            return formattedDate
        } else {
            return " .......... "
        }
    }
    
    func getLocationLabel() -> String {
        let item = model?.user?.location
        if let item = item {
            return item
        } else {
            return " .......... "
        }
    }
    
    func getDownloadsLabel() -> String {
        let item = model?.downloads
        
        if let item = item {
            return "Downloaded \(String(item)) times"
        } else {
            return ""
        }
    }
    
    //MARK: - Transform data from model in Images
    
    func downloadPhoto(){
        let data = model?.picture
        if let data = data {
            view?.setUpPhoto(image: UIImage(data: data)!)
        } else {
            view?.setUpPhoto(image: UIImage(systemName: "trash")!)
        }
    }
}


//MARK: - Date formatter
extension DetailsPresenter {
    private func setDateFormat(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backendDate = dateFormatter.date(from: date) else { return "" }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd-MM-yyyy"
        let date = formatDate.string(from: backendDate)
        return date
    }
}
