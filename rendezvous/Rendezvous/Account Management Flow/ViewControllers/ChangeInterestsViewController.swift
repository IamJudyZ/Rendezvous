//
//  ChangeInterestsViewController.swift
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

class ChangeInterestsViewController: UIViewController {

    var currentUser: User!
    let userID = Auth.auth().currentUser!.uid
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //BING: This lets the user change the interests they selected. Should be relatively similar to SelectInterestsViewController. Maybe when it first shows up, all the interests they selected before would be a different color
    //BING: Also, the segue to get here should be when the user clicks on the textField called interestsText, I'm not sure how to do that since I'm already using textFieldDidBeginEditing to manage the PickerViews. But the segue to get here has the identifier: interestsSegue
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
