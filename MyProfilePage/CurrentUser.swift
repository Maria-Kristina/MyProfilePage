//
//  CurrentUser.swift
//  StudyPath
//
//  Created by Maria-Kristina Sillanmäki on 04/05/2019.
//  Copyright © 2019 Maria-Kristina Sillanmäki. All rights reserved.
//

import Foundation

class CurrentUser{
    
    static let shared = CurrentUser()
    var person: Person!
    
    private init(){}
    
    func addUser(person: Person){
        self.person = person
        print("\(person.name) added")
    }
    func getUser() -> Person {
        return person
    }
}
