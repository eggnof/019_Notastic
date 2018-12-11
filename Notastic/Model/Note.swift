//
//  Note.swift
//  Notastic
//
//  Created by Bryce Poole on 12/8/18.
//  Copyright © 2018 Bryce Poole. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var contents : String = ""
    
    //Define relationship to parent object
    var parentCategory = LinkingObjects(fromType: Category.self, property: "noteList")
}
