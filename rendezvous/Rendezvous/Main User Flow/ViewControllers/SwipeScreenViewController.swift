//
//  SwipeScreenViewController.swift
//  Rendezvous
//
//  Created by Diego Mendoza on 11/18/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit
import SwiftUI

class SwipeScreenViewController: UIViewController {
    
    let swipeScreen = UIHostingController(rootView: SwipeScreen())

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(swipeScreen)
        view.addSubview(swipeScreen.view)
        swipeScreen.didMove(toParent: self)
        setupConstraints()
    }
    
    fileprivate func setupConstraints()
    {
        swipeScreen.view.translatesAutoresizingMaskIntoConstraints = false
//        swipeScreen.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        swipeScreen.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        swipeScreen.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        swipeScreen.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        NSLayoutConstraint.activate([
            swipeScreen.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            swipeScreen.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            swipeScreen.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swipeScreen.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
