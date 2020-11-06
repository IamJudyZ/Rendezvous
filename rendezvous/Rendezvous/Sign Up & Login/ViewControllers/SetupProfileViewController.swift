//
//  SetupProfileViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/5/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

//class SetupProfileViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}

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
