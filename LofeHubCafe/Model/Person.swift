//
//  Person.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import Foundation
import RealmSwift

class RealmPerson: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var age = ""
    @Persisted var phone = ""
    @Persisted var height = ""
    @Persisted var find = ""
    @Persisted var hobby = ""
    @Persisted var image: Data?
}
