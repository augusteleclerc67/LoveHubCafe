//
//  RealmReservation.swift
//  LofeHubCafe
//
//  Created by D K on 30.09.2024.
//

import Foundation
import RealmSwift

class RealmReservation: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var name = ""
    @Persisted var date = Date()
    @Persisted var code = ""
    @Persisted var table = ""
}
