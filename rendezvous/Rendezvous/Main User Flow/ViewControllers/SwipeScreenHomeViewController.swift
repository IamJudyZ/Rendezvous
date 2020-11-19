//
//  SwipeScreenHomeViewController.swift
//  Rendezvous
//
//  Created by Bing Chen on 11/19/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

class SwipeScreenHomeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        instantiateVC()
        // Do any additional setup after loading the view.
    }
    

    func instantiateVC() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SwipeScreen", bundle: nil)
        let swipeScreen = storyBoard.instantiateViewController(withIdentifier: "swipeScreenVC") as! SwipeScreenViewController
        swipeScreen.modalPresentationStyle = .fullScreen
        //self.present(swipeScreen, animated: true, completion: nil)
        self.navigationController?.pushViewController(swipeScreen, animated: true)
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
