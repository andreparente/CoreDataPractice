//
//  User.swift
//  CoreDataPractice
//
//  Created by Andre Machado Parente on 4/5/16.
//  Copyright © 2016 Andre Machado Parente. All rights reserved.
//

import UIKit
import CoreData

public var userList: [NSManagedObject] = []

public class Usuario {
    
    var name: String
    var email: String
    var password: Double
    var age: Int
    
    init(name: String, email: String, password: Double, age:Int) {
        self.name = name
        self.email = email
        self.password = password
        self.age = age
    }
    
}
