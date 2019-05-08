//
//  ViewController.swift
//  StudyPath
//
//  Created by Maria-Kristina Sillanmäki on 18/04/2019.
//  Copyright © 2019 Maria-Kristina Sillanmäki. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    var person: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 5
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            signInTapped(signInButton)
        }
        return true
    }
    
    // MARK: Signing in
    @IBAction func signInTapped(_ sender: UIButton) {
        if let email = emailTextField.text {
            if let password = passwordTextField.text {
                checkFromJson(email: email, password: password)
            }
        }
    }
    
    //MARK: Checking the userdata from json
    func checkFromJson(email: String, password: String) {
        
        let path = Bundle.main.path(forResource: "userdata", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url)
        let obj = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        
        let users = obj?["users"] as? [[String:Any]]
        let userCount = obj?["userCount"] as? String
        var i = 0
        var coursesTakenList = [String]()
        var coursesInProgressList = [String]()
        while(i < Int(userCount ?? "0") ?? 0){
            let emailFromJson = users?[i]["email"] as? String
            let passwordFromJson = users?[i]["password"] as? String
            if email == emailFromJson && password == passwordFromJson{
                
                let coursesTakenCount = users?[i]["coursesTakenCount"] as? String
                let coursesTaken = users?[i]["coursesTaken"] as? [[String:Any]]
                var a = 0
                while(a < Int(coursesTakenCount ?? "0") ?? 0){
                    let course = coursesTaken?[a]["courseName"] as? String
                    coursesTakenList.append(course ?? "none")
                    a += 1
                }
                let coursesInProgressCount = users?[i]["coursesInProgressCount"] as? String
                let coursesInProgress = users?[i]["coursesInProgress"] as? [[String:Any]]
                var b = 0
                while(b < Int(coursesInProgressCount ?? "0") ?? 0){
                    let course = coursesInProgress?[b]["courseName"] as? String
                    coursesInProgressList.append(course ?? "none")
                    b += 1
                }
                person = Person(name: users?[i]["userName"] as! String, email: emailFromJson ?? "", coursesTakenArray: coursesTakenList, coursesInProgressArray: coursesInProgressList)
                
                CurrentUser.shared.addUser(person: person)
                
                performSegue(withIdentifier: "Signin", sender: nil)
            } else {
                emailTextField.text = ""
                passwordTextField.text = ""
            }
            i += 1
        }
    }
}

