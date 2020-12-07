//
//  ConversationsViewController.swift
//  Messenger
//
//  Created by Judy Zhang on 11/11/20.
//

import UIKit
//import FirebaseAuth

class ConversationsViewController: UIViewController {
    
    let data = ["Bing Chen", "Edward Cullen"]
    
    //importante
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = false
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
//    private let noConversationsLabel: UILabel = {
//        let label = UILabel()
//        label.text = "No conversations"
//        label.textAlignment = .center
//        label.textColor = .gray
//        label.font = .systemFont(ofSize: 21, weight: .medium)
//        label.isHidden = true
//        return label
//    }()
//
    
    //importante
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        //view.addSubview(noConversationsLabel)
        setupTableView()
        //fetchConversations()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        validateAuth()
//
//    }
    
//    //shows loginpage if auth is nil
//    private func validateAuth() {
//        if FirebaseAuth.Auth.auth().currentUser == nil {
//            //right here
//            let vc = LoginViewController()
//            let nav = UINavigationController(rootViewController: vc)
//            nav.modalPresentationStyle = .fullScreen
//            present(nav, animated: false)
//        }
//    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

//    private func fetchConversations() {
//        // fetches from firebase
//        //either shows label, or the table view
//
//
//        //GET THIS FROM BACKEND
//
//        tableView.isHidden = false
//    }
}

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let num = indexPath.row
        if num == 1 {
            let vc = ChatViewController()
            vc.title = "Jenny Smith"
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        }
        if num == 0 {
            let vid = VideoChatViewController()
            vid.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vid, animated: true)

        }
        
//        let vc = ChatViewController()
//        vc.title = "Jenny Smith"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
    }
}

