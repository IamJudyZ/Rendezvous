////
////  ChatViewController.swift
////  Rendezvous
////
////  Created by Judy Zhang on 11/19/20.
////  Copyright © 2020 NYUiOS. All rights reserved.
////
//
//import UIKit
//import MessageKit
//import InputBarAccessoryView
//import Firebase
//import FirebaseFirestore
//import SDWebImage
//import FirebaseAuth
//
//
//class ChatViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
//
//
//    //var currentUser: User = Auth.auth().currentUser!
//    
//    
//    // MARK: This needs the current user, not a placeholder new instance
//    var currentUser: User!
//    let userID = Auth.auth().currentUser!.uid
//    let db = Firestore.firestore()
//    
//    var user2Name: String?
//    var user2ImgUrl: String?
//    var user2UID: String?
//    
//    private var docReference: DocumentReference?
//    
//    var messages: [Message] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.title = user2Name ?? "Chat"
//        
//        getUserInfo()
//        
//        navigationItem.largeTitleDisplayMode = .never
//        maintainPositionOnKeyboardFrameChanged = true
//        messageInputBar.inputTextView.tintColor = .red
//        messageInputBar.sendButton.setTitleColor(.red, for: .normal)
//        
//        messageInputBar.delegate = self
//        messagesCollectionView.messagesDataSource = self
//        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDisplayDelegate = self
//        
//        loadChat()
//        
//    }
//    
//    // MARK: - Custom messages handlers
//    
//    func getUserInfo() {
//            db.collection("users").document(userID).getDocument { (document, error) in
//                if let error = error {
//                    print(error)
//                    return
//                }
//                let result = Result {
//                    try document?.data(as: User.self)
//                }
//                switch result {
//                    case .success(let newUserFromDb):
//                        self.currentUser = newUserFromDb
//                        //self.initText()
//                    case .failure(let error):
//                        print(error)
//                }
//            }
//        }
//    
//    func createNewChat() {
//        let users = [self.userID, self.user2UID]
//         let data: [String: Any] = [
//             "users":users
//         ]
//         
//         let db = Firestore.firestore().collection("Chats")
//         db.addDocument(data: data) { (error) in
//             if let error = error {
//                 print("Unable to create chat! \(error)")
//                 return
//             } else {
//                 self.loadChat()
//             }
//         }
//    }
//    
//    func loadChat() {
//        
//        //Fetch all the chats which has current user in it
//        let db = Firestore.firestore().collection("Chats")
//                .whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
//        
//        
//        db.getDocuments { (chatQuerySnap, error) in
//            
//            if let error = error {
//                print("Error: \(error)")
//                return
//            } else {
//                
//                //Count the no. of documents returned
//                guard let queryCount = chatQuerySnap?.documents.count else {
//                    return
//                }
//                
//                if queryCount == 0 {
//                    //If documents count is zero that means there is no chat available and we need to create a new instance
//                    self.createNewChat()
//                }
//                else if queryCount >= 1 {
//                    //Chat(s) found for currentUser
//                    for doc in chatQuerySnap!.documents {
//                        
//                        let chat = Chat(dictionary: doc.data())
//                        //Get the chat which has user2 id
//                        if (chat?.users.contains(self.user2UID!))! {
//                            
//                            self.docReference = doc.reference
//                            //fetch it's thread collection
//                             doc.reference.collection("thread")
//                                .order(by: "created", descending: false)
//                                .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
//                            if let error = error {
//                                print("Error: \(error)")
//                                return
//                            } else {
//                                self.messages.removeAll()
//                                    for message in threadQuery!.documents {
//
//                                        let msg = Message(dictionary: message.data())
//                                        self.messages.append(msg!)
//                                        print("Data: \(msg?.content ?? "No message found")")
//                                    }
//                                self.messagesCollectionView.reloadData()
//                                self.messagesCollectionView.scrollToBottom(animated: true)
//                            }
//                            })
//                            return
//                        } //end of if
//                    } //end of for
//                    self.createNewChat()
//                } else {
//                    print("Let's hope this error never prints!")
//                }
//            }
//        }
//    }
//    
//    
//    private func insertNewMessage(_ message: Message) {
//        
//        messages.append(message)
//        messagesCollectionView.reloadData()
//        
//        DispatchQueue.main.async {
//            self.messagesCollectionView.scrollToBottom(animated: true)
//        }
//    }
//    
//    private func save(_ message: Message) {
//        
//        let data: [String: Any] = [
//            "content": message.content,
//            "created": message.created,
//            "id": message.id,
//            "senderID": message.senderID,
//            "senderName": message.senderName
//        ]
//        
//        docReference?.collection("thread").addDocument(data: data, completion: { (error) in
//            
//            if let error = error {
//                print("Error Sending message: \(error)")
//                return
//            }
//            
//            self.messagesCollectionView.scrollToBottom()
//            
//        })
//    }
//    
//    // MARK: - InputBarAccessoryViewDelegate
//    
//            func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
//
//                let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: userID, senderName: currentUser.firstName)
//                
//                  //messages.append(message)
//                  insertNewMessage(message)
//                  save(message)
//    
//                  inputBar.inputTextView.text = ""
//                  messagesCollectionView.reloadData()
//                  messagesCollectionView.scrollToBottom(animated: true)
//            }
//    
//    
//    // MARK: - MessagesDataSource
//    func currentSender() -> SenderType {
//        
//        return Sender(id: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.displayName ?? "Name not found")
//        
//    }
//    
//    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
//        
//        return messages[indexPath.section]
//        
//    }
//    
//    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
//        
//        if messages.count == 0 {
//            print("No messages to display")
//            return 0
//        } else {
//            return messages.count
//        }
//    }
//    
//    
//    // MARK: - MessagesLayoutDelegate
//    
//    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
//        return .zero
//    }
//    
//    // MARK: - MessagesDisplayDelegate
//    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
//        return isFromCurrentSender(message: message) ? .blue: .lightGray
//    }
//
//    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
//        
//        if message.sender.senderId == userID {
//            SDWebImageManager.shared.loadImage(with: URL(string: "michael"),
//                                               //currentUser.profilePic
//                                               options: .highPriority,
//                                               progress: nil) {
//                (image, data, error, cacheType, isFinished, imageUrl) in
//                avatarView.image = image
//            }
//        } else {
//            SDWebImageManager.shared.loadImage(with: URL(string: user2ImgUrl!), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
//                avatarView.image = image
//            }
//        }
//    }
//
//    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
//
//        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
//        return .bubbleTail(corner, .curved)
//
//    }
//    
//}
