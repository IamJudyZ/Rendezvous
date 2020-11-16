//
//  EditProfileViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/16/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

class EditProfileViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var preferenceText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var heightFeetText: UITextField!
    @IBOutlet weak var heightInchText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var professionText: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //Components for PickerViews
    var selectedGender: String?
    var selectedGenderRow: Int = 0
    var genderList = ["", "Woman", "Man", "Other"]
    var selectedPreference: String?
    var selectedPreferenceRow: Int = 0
    var preferenceList = ["", "Woman", "Man", "Everyone"]
    var selectedAge: String?
    var selectedAgeRow: Int = 0
    var ageList = [""]
    var selectedHeightFeet: String?
    var selectedHeightFeetRow: Int = 0
    var heightFeetList = ["", "3", "4", "5", "6", "7", "8", "9"]
    var selectedHeightInch: String?
    var selectedHeightInchRow: Int = 0
    var heightInchList = ["", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
//
//    //Keeps track of which PickerView TextField is selected
    var currentTextField: UITextField!
    var pickerView = UIPickerView()
    
    var currentUser: User!
    let userID = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // Do any additional setup after loading the view.
        createAgeList()
    }
    
    func createAgeList() {
        for num in 18...65 {
            ageList.append(String(num))
        }
    }

    func getUserInfo() {
        db.collection("users").document(userID).getDocument { (document, error) in
            if let error = error {
                print(error)
                return
            }
            let result = Result {
                try document?.data(as: User.self)
            }
            switch result {
                case .success(let newUserFromDb):
                    self.currentUser = newUserFromDb
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    func initUser(user: User) {
        let fName = user.firstName
        let lName = user.lastName
        let em = user.email
        
        self.currentUser = User(fName: fName, lName: lName, eMail: em)
        currentUser.gender = user.gender
        currentUser.preference = user.preference
        currentUser.age = user.age
        currentUser.heightFeet = user.heightFeet
        currentUser.heightInch = user.heightInch
        currentUser.city = user.city
        currentUser.state = user.state
        currentUser.profession = user.profession
        currentUser.selfDescription = user.selfDescription
    }
    
    func updateText() {
        genderText.text! = currentUser.gender
        preferenceText.text! = currentUser.preference
        ageText.text! = currentUser.age
        heightFeetText.text! = currentUser.heightFeet
        heightInchText.text! = currentUser.heightInch
        cityText.text! = currentUser.city
        stateText.text! = currentUser.state
        professionText.text! = currentUser.profession
        descriptionText.text! = currentUser.selfDescription
    }
    
    func updateUser() {
        currentUser.gender = genderText.text!
        currentUser.preference = preferenceText.text!
        currentUser.age = ageText.text!
        currentUser.heightFeet = heightFeetText.text!
        currentUser.heightInch = heightInchText.text!
        currentUser.city = cityText.text!
        currentUser.state = stateText.text!
        currentUser.profession = professionText.text!
        currentUser.selfDescription = descriptionText.text!
    }
    
    @IBAction func manageAccount(_ sender: Any) {
        self.performSegue(withIdentifier: "accountSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "accountSegue") {
//            let destinationVC = segue.destination as! ManageAccountViewController
//            destinationVC.currentUser = self.user
        }
    }
    
    //PickerView functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch currentTextField {
            case genderText: return genderList.count
            case preferenceText: return preferenceList.count
            case ageText: return ageList.count
            case heightFeetText: return heightFeetList.count
            case heightInchText: return heightInchList.count
            default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch currentTextField {
            case genderText: return genderList[row]
            case preferenceText: return preferenceList[row]
            case ageText: return ageList[row]
            case heightFeetText: return heightFeetList[row]
            case heightInchText: return heightInchList[row]
            default: return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch currentTextField {
            case genderText:
                selectedGender = genderList[row]
                genderText.text = selectedGender
                selectedGenderRow = row
            case preferenceText:
                selectedPreference = preferenceList[row]
                preferenceText.text = selectedPreference
                selectedPreferenceRow = row
            case ageText:
                selectedAge = ageList[row]
                ageText.text = selectedAge
                selectedAgeRow = row
            case heightFeetText:
                selectedHeightFeet = heightFeetList[row]
                heightFeetText.text = selectedHeightFeet
                selectedHeightFeetRow = row
            case heightInchText:
                selectedHeightInch = heightInchList[row]
                heightInchText.text = selectedHeightInch
                selectedHeightInchRow = row
            default:
                print("No field selected")
        }
    }
    
    //Creates a PickerView within a UITextField
    func createPickerView(textField: UITextField) {
        textField.inputView = pickerView
    }
    
    //Close PickerView once something is selected
    func dismissPickerView(textField: UITextField) {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
       let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.donePicking))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       textField.inputAccessoryView = toolBar
    }
    
    //Leaves the PickerView when user push the Done button
    @objc func donePicking() {
        view.endEditing(true)
    }
    
    //Delegate which picks up which PickerView TextField the user is in
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField
        
        //Select empty item by default and if re-enter TextField, will stay on selected item
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        switch currentTextField {
            case genderText:
                if selectedRow != selectedGenderRow {
                    pickerView.selectRow(selectedGenderRow, inComponent: 0, animated: false)
                }
            case preferenceText:
                if selectedRow != selectedPreferenceRow {
                    pickerView.selectRow(selectedPreferenceRow, inComponent: 0, animated: false)
                }
            case ageText:
                if selectedRow != selectedAgeRow {
                    pickerView.selectRow(selectedAgeRow, inComponent: 0, animated: false)
                }
            case heightFeetText:
                if selectedRow != selectedHeightFeetRow {
                    pickerView.selectRow(selectedHeightFeetRow, inComponent: 0, animated: false)
                }
            case heightInchText:
                if selectedRow != selectedHeightInchRow {
                    pickerView.selectRow(selectedHeightInchRow, inComponent: 0, animated: false)
                }
            default: print(selectedRow)
        }
        
        createPickerView(textField: currentTextField)
        dismissPickerView(textField: currentTextField)
    }
}