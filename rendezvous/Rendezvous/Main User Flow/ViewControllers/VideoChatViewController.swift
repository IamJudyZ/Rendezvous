//
//  VideoChatViewController.swift
//  Rendezvous
//
//  Created by Judy Zhang on 12/6/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

class VideoChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func hangUpClicked(_ sender: Any) {
        let vc = ConversationsViewController()
        navigationController?.pushViewController(vc, animated: true)

        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
