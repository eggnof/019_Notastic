//
//  Category.swift
//  Notastic
//
//  Created by Bryce Poole on 12/9/18.
//  Copyright © 2018 Bryce Poole. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    
    let noteList = List<Note>() //Create list to contain all Note child objects of this category
}
