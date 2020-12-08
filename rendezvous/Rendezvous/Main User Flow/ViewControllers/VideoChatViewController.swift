//
//  VideoChatViewController.swift
//  Rendezvous
//
//  Created by Judy Zhang on 12/6/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

class VideoChatViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = self.imageView.frame.size.height/2
        // Do any additional setup after loading the view.
    }
    
//    @IBAction func hangUpClicked(_ sender: Any) {
////        let storyboard = UIStoryboard(name: "Main", bundle: nil)
////        let vc = storyboard.instantiateViewController(identifier: "conversationsVC") as UIViewController
////        vc.modalPresentationStyle = .fullScreen
////        self.present(vc, animated: true, completion: nil)
////
//    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
