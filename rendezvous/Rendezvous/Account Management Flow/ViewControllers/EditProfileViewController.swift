//
//  EditProfileViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/16/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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

}
