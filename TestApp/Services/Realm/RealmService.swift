
//
//  RealmService.swift
//
//
//  Created by Шамиль Моллачиев on 04.02.2022.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    func saveDelete(picture: RealmPictureModel)
    var picturesInRealm: Results<RealmPictureModel>? { get set }
    func imageExistInRealm(model: RealmPictureModel) -> Bool
    func delete(model: RealmPictureModel)
}

class RealmService: RealmServiceProtocol {

    init() {
        obtainUsers()
    }
    
    var realm = try! Realm()
    var picturesInRealm: Results<RealmPictureModel>?
    
    func imageExistInRealm(model: RealmPictureModel) -> Bool {
        obtainUsers()
        if picturesInRealm?.count != 0 {
        for i in 0...picturesInRealm!.count - 1{
            if picturesInRealm![i].name == model.name {
                return true
            }
        }
        return false
        } else {
            return false
        }
    }
    
    
    func saveDelete(picture: RealmPictureModel) {
        obtainUsers()
        if picturesInRealm?.count != 0 {
            for i in 0...picturesInRealm!.count - 1{
                if picturesInRealm![i].name == picture.name {
                    delete(model: picture )
                    return
                }
            }
            save(picture: picture)
            
        } else {
            save(picture: picture)
        }
    }
    
    func save(picture: RealmPictureModel) {
        
        do {
            try realm.write {
                realm.add(picture)
            }
        } catch {
            print("Error saving context \(error)")
        }
    }
    
    func delete(model: RealmPictureModel) {
        obtainUsers()
        do {
            try realm.write {
                realm.delete(realm.objects(RealmPictureModel.self).filter("name=%@",model.name))
            }
        } catch {
            print("Error deleting context \(error)")
        }
    }
 
    
    func obtainUsers() {
        let realm = try! Realm()
        picturesInRealm = realm.objects(RealmPictureModel.self)
    }
}
