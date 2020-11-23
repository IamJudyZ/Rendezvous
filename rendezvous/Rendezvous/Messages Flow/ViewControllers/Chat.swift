//
//  Chat.swift
//  Rendezvous
//
//  Created by Judy Zhang on 11/19/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//

import UIKit

struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
        return ["users": users]
    }
}



extension Chat {
    init?(dictionary: [String:Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {return nil}
        self.init(users: chatUsers)
    }
}
