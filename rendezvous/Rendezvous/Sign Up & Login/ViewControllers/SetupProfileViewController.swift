//
//  SetupProfileViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/5/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class SetupProfileViewController: UIViewController {
    
    
    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var heightText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var professionText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var currentUser: User!
    let userID = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
        
    override func viewDidLoad() {
        errorLabel.isHidden = true
        super.viewDidLoad()
    }
    
    //Hide keyboard when user taps outside the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //Hide keyboard when user taps 'return' on keyboard
    func textFieldShouldReturn(_textField: UITextField) -> Bool {
        _textField.resignFirstResponder();
    }
    
    @IBAction func setupProfile(_ sender: Any) {
        if (checkFields()) {
            updateUser()
            do {
                try _ = db.collection("users").document(userID).setData(from:self.currentUser)
            } catch {
                print("Unable to update user data on Firebase")
            }
            //transitionToHomeScreen()
            self.performSegue(withIdentifier: "interestsSegue", sender: nil)
        }
    }
    
    func updateUser() {
        currentUser.gender = genderText.text!
        currentUser.age = ageText.text!
        // TODO: change this back to currentUser.height = heightText.text! to avoid merge conflicts
        currentUser.heightFeet = heightText.text!
        currentUser.city = cityText.text!
        currentUser.state = stateText.text!
        currentUser.profession = professionText.text!
        currentUser.selfDescription = descriptionText.text!
    }
    
    func checkFields() -> Bool {
        //Ensure all fields filled out
        if(genderText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ageText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || heightText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || cityText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || stateText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || professionText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || descriptionText.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
            callError(errorText: "One or more fields have been left empty")
            return false
        }
        return true
    }
    
    func callError(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "interestsSegue") {
            let destinationVC = segue.destination as! SelectInterestsViewController
            destinationVC.currentUser = self.currentUser
        }
    }
    
//    func transitionToHomeScreen() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "homeVC") as UIViewController
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
//    }
}

//BING: The below is for selecting age, gender, and height from a selection of choices but it cause a weird erryr so I had to comment it out. Just uncomment the regular one

//class SetupProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
//    @IBOutlet var gender: UITextField!
//
//    var selectedGender: String?
//    var gendersList = ["female", "male", "other"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
    
//    func createPickerView() {
//           let pickerView = UIPickerView()
//           pickerView.delegate = self
//           gender.inputView = pickerView
//    }
//
//    func dismissPickerView() {
//       let toolBar = UIToolbar()
//       toolBar.sizeToFit()
//       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
//       toolBar.setItems([button], animated: true)
//       toolBar.isUserInteractionEnabled = true
//       gender.inputAccessoryView = toolBar
//    }
//
//    @objc func action() {
//          view.endEditing(true)
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return gendersList.count
//    }
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return gendersList[row]
//    }
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        selectedGender = gendersList[row]
//        gender.text = selectedGender
//    }
//}
