//
//  SwipeScreen.swift
//  Rendezvous
//
//  Created by Diego Mendoza on 11/11/20.
//  Copyright © 2020 NYUiOS. All rights reserved.
//
//
//
//  DatingApp.swift
//  Dating
//
//  Created by Balaji on 30/06/20.

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore

let rendezvousBlue = Color.init(red: 0/255, green: 30/255, blue: 80/255)

let rendezvousYellow = Color.init(red: 255/255, green: 232/255, blue: 164/255)

struct SwipeScreen: View {
    var body: some View {
        Home()
    }
}

struct SwipeScreen_Previews: PreviewProvider {
    static var previews: some View {
        SwipeScreen()
    }
}

struct Home : View {
    
//    @State var profiles = [
//
//        // Draw the data from firebase
//
//        Profile(id: 0, name: "Annie Watson", image: "testPicture", age: "27", offset: 0),
//        Profile(id: 1, name: "Clarie", image: "testPicture", age: "19", offset: 0),
//        Profile(id: 2, name: "Catherine", image: "testPicture", age: "25", offset: 0),
//        Profile(id: 3, name: "Emma", image: "testPicture", age: "26", offset: 0),
//        Profile(id: 4, name: "Juliana", image: "testPicture", age: "20", offset: 0),
//        Profile(id: 5, name: "Kaviya", image: "testPicture", age: "22", offset: 0),
//        Profile(id: 6, name: "Jill", image: "testPicture", age: "18", offset: 0),
//        Profile(id: 7, name: "Terasa", image: "testPicture", age: "29", offset: 0),
//    ]
    
    
    @ObservedObject var profileViewModel = ProfileViewModel()
    
    //@State var profiles = []
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                Spacer();
                Image("r").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25.0, height: 25.0, alignment: .center)

                Spacer(minLength: 0)
            }
            .foregroundColor(.black)
            .padding()
            .onAppear() {
                profileViewModel.getProfiles()
            }
            GeometryReader{g in
                ForEach(profileViewModel.profiles) { p in
                    ZStack{
                        ProfileView(profile: p, frame: g.frame(in: .global))
                    }
                }
            }
            .padding([.horizontal,.bottom])
        }
        .background(rendezvousYellow.edgesIgnoringSafeArea(.all))
        .onAppear() {
            profileViewModel.getProfiles()
        }
    }
}


struct ProfileView: View {
    
    @State var profile: Profile
    var frame: CGRect

//    self.frame.backgroundColor = UIColor.red
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
            Color.white
            VStack{
                Image(profile.profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame.width,height: frame.width, alignment: Alignment(horizontal: .center, vertical: .center))
            }
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                (profile.offset > 0 ? Color.green : Color.red)
                    .opacity(profile.offset != 0 ? 0.7 : 0)
                
                HStack{
                    if profile.offset < 0{
                        Spacer()
                    }
                    
                    Text(profile.offset == 0 ? "" : (profile.offset > 0 ? "Liked" : "Rejected"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 25)
                        .padding(.horizontal)
                    
                    if profile.offset > 0 {
                        Spacer()
                    }
                }
            })
//            LinearGradient(gradient: .init(colors: [Color.black.opacity(0),Color.black.opacity(0.4)]), startPoint: .center, endPoint: .bottom
            VStack(){
                HStack{
                    VStack(alignment: .leading,spacing: 5){
                        Spacer(minLength: 0)
                        Text(profile.name)
                            .font(.title)
                            .fontWeight(.bold).foregroundColor(.black)
                        
                        Text("Age: " + profile.age)
                        .fontWeight(.bold)
                        Text(profile.city + ", " + profile.state)
                        Text(profile.selfDescription)
                        .fontWeight(.light)
                    }
                    .foregroundColor(.gray)
                    
                    Spacer(minLength: 0)
                }.padding(.bottom, 50)
                
                HStack(spacing: 25){
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.8)) {
                            self.profile.offset = -700
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.all,20)
                            .background(Color.red)
                            .clipShape(Circle())
                    })
                    
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.8)) {
                            self.profile.offset = 700
                        }
                    }, label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .padding(.all,20)
                            .background(Color.green)
                            .clipShape(Circle())
                    })
                    
                    Spacer(minLength: 0)
                }
            }
            .padding(.all)
        })
        .cornerRadius(20)
        .offset(x: profile.offset)
        .rotationEffect(.init(degrees: profile.offset == 0 ? 0 : (profile.offset > 0 ? 12 : -12)))
        .gesture(
        
            DragGesture()
                .onChanged({ (value) in
                    withAnimation(.default) {
                        self.profile.offset = value.translation.width
                    }
                })
                .onEnded({ (value) in
                    withAnimation(.easeIn) {
                        if self.profile.offset > 150 {
                            self.profile.offset = 700
                        }
                        else if self.profile.offset < -150 {
                            self.profile.offset = -700
                        }
                        else{
                            self.profile.offset = 0
                        }
                    }
                })
        )
    }
}

struct Profile : Identifiable {
    @DocumentID var id: String?
//    var firstName: String
//    var lastName: String
    var name: String
    var gender: String
    var preference: String
    var age: String
    var heightFeet: String
    var heightInch: String
    var city: String
    var state: String
    var profession: String
    var selfDescription: String
    var interests: Array<String>
    var profilePic: String
    var offset: CGFloat
}
