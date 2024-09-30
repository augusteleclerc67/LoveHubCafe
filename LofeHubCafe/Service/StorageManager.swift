//
//  StorageManager.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import SwiftUI
import RealmSwift


class StorageManager {
    
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    @ObservedResults(RealmPerson.self) var persons
    @ObservedResults(RealmReservation.self) var reservations
    
    func createOrUpdatePerson(age: String, phone: String, height: String, find: String, hobby: String, image: Data?) {
        do {
            if let firstPerson = persons.first {
                try realm.write {
                    firstPerson.age = age
                    firstPerson.phone = phone
                    firstPerson.height = height
                    firstPerson.find = find
                    firstPerson.hobby = hobby
                    firstPerson.image = image
                }
            } else {
                
                let newPerson = RealmPerson()
                newPerson.age = age
                newPerson.phone = phone
                newPerson.height = height
                newPerson.find = find
                newPerson.hobby = hobby
                newPerson.image = image
                
                
                try realm.write {
                    realm.add(newPerson)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    func saveReservation(date: Date, name: String) {
        let reservation = RealmReservation()
        reservation.date = date
        reservation.code = DataManager.shared.generateCode()
        reservation.table = DataManager.shared.generateTable()
        reservation.name = name
        
        do {
            try realm.write {
                realm.add(reservation)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
  
}


