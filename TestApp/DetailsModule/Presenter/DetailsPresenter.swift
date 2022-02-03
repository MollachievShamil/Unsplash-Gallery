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
    init(view: DetailsViewProtocol, router: RouterProtocol, model: PhotoModel, networkService: NetworkServiceProtocol)
    var model: PhotoModel? {get set}
    func getNameLabel() -> String
    func getDateOfCreationLabel() -> String
    func getLocationLabel() -> String
    func getDownloadsLabel() -> Int
    func downloadPhoto()
}


class DetailsPresenter: DetailsPresenterProtocol {
   
  
    weak var view: DetailsViewProtocol?
    let router: RouterProtocol?
    var networkService: NetworkServiceProtocol?
    var model: PhotoModel?
    
    required init(view: DetailsViewProtocol, router: RouterProtocol, model: PhotoModel, networkService: NetworkServiceProtocol) {
        self.view = view
        self.router = router
        self.model = model
        self.networkService = networkService
        downloadPhoto()
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
    
    func getDownloadsLabel() -> Int {
        let item = model?.downloads
        if let item = item {
            return item
        } else {
            return 0
        }
    }
   
    //MARK: - Download photo
    func downloadPhoto(){
        guard let model = model else {return}

        networkService?.fetcImage(from: model, response: { data in
            if let data = data {
                let image = UIImage(data: data)
                self.view?.setUpPhoto(image: image!)
            }
        })
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
