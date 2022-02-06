
//
//  RealmPictureModel.swift
//
//
//  Created by Шамиль Моллачиев on 04.02.2022.
//

import Foundation
import RealmSwift

class RealmPictureModel: Object {
    @objc dynamic var name = String()
    @objc dynamic var pictureData = Data()
    @objc dynamic var downloads = Int()
    @objc dynamic var createdAt = String()
    @objc dynamic var URL = String()
    @objc dynamic var location = String()
    
}
