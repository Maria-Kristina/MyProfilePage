//
//  Person.swift
//  StudyPath
//
//  Created by Maria-Kristina Sillanmäki on 01/05/2019.
//  Copyright © 2019 Maria-Kristina Sillanmäki. All rights reserved.
//

import Foundation

class Person {
    let name: String
    var email: String
    var coursesTakenArray = [String]()
    var coursesInProgressArray = [String]()
    
    init(name: String, email: String, coursesTakenArray: Array<String>, coursesInProgressArray: Array<String>){
        self.name = name
        self.email = email
        self.coursesTakenArray = coursesTakenArray
        self.coursesInProgressArray = coursesInProgressArray
        
    }
}
