
//
//  RealmService.swift
//
//
//  Created by Шамиль Моллачиев on 04.02.2022.
//

import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    //func save(user: User)
}

class RealmService: RealmServiceProtocol {
    
 //   static var shared = RealmService()
    
    var realm = try! Realm()
  
    var picturesInRealm: Results<RealmPictureModel>?
    
 
    func saveDelete(picture: RealmPictureModel) {
        obtainUsers()
        
        if picturesInRealm?.count != 0 {
        
        for i in 0...picturesInRealm!.count - 1{
                    if picturesInRealm![i].name == picture.name {
                       delete(model: picture )
                        print(picturesInRealm)
                        return
                    }
        }
                      save(picture: picture)
        print(picturesInRealm)
       
        } else {
            save(picture: picture)
        }
        
    }
    
    func save(picture: RealmPictureModel) {
       
        do {
            try realm.write {
                realm.add(picture)
                    print("saved")
            }
        } catch {
            print("Error saving context \(error)")
        }
    }

    func delete(model: RealmPictureModel) {
       obtainUsers()
        do {
            try realm.write {
               // realm.delete(picturesInRealm![0])
                realm.delete(realm.objects(RealmPictureModel.self).filter("name=%@",model.name))
                print("deleted")
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
