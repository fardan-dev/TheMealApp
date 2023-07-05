//
//  CategoryEntity.swift
//  TheMeal
//
//  Created by telkom on 05/07/23.
//

import Foundation
import RealmSwift

class CategoryEntity: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var desc: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
