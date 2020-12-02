//
//  loginViewController.swift
//  Rendezvous
//
//  Created by Ramses Sanchez Hernandez on 11/2/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    //Components from Storyboard
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var login: UIButton!
    
    let rendezvousBlue = UIColor.init(red: 0/255, green: 30/255, blue: 80/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        setUpTextField(password)
        setUpTextField(email)
        login.layer.cornerRadius = 15
        login.clipsToBounds = true
        
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            if user != nil{
//                self.transitionToHomeScreen()
//            }
//        }
        
    }
    
    func setUpTextField(_ textField: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height-5, width: textField.frame.width, height: 2)
        bottomLine.backgroundColor = rendezvousBlue.cgColor
        textField.background = .none
        textField.layer.addSublayer(bottomLine)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
        _textField.resignFirstResponder()
    }
    
    func checkFields() -> Bool {
        if email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            callError(errorText: "One or more fields have been left empty")
            return false
        }
        return true
    }
    
    @IBAction func loginPressed(_ sender: Any) {
         if checkFields() {
             //Remove spaces and new line characters from the email and password textfields
             let em = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let pword = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             
             //If error while authenticating, display error
             //Else transition to home screen
             Auth.auth().signIn(withEmail: em, password: pword) { (result, error) in
                 if error != nil {
                     self.callError(errorText: "Incorrect Email or Password")
                 }
                 else {
                     self.transitionToHomeScreen()
                 }
             }
         }
    }
    
    func callError(errorText: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorText
    }
    
    func transitionToHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeVC") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
