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
let darkYellow = Color.init(red: 254/255, green: 189/255, blue: 97/255)



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
    @State var profiles = [
        
        
//        Profile(id:0, name:"Judy Zhang", profilePic:"JudyZhang",age:"22", heightFeet:"5", heightInch:"4", city:"Los Angeles", state:"CA", selfDescription: "Product owner of Rendezvous. Worked on chat and video call functionality. Loves rock climbing and knitting. Looking for someone to move to Montana with :)", offset: 0),
        Profile(id:1, name:"Bing Chen", profilePic:"BingChen",age:"22", heightFeet:"5", heightInch:"3", city:"Brandon", state:"FL", selfDescription: "Scrum master, and worked on profiles.", profession: "Software Engineer", interest1: "vegan", interest2: "women in tech", interest3: "elections", offset: 0),
        Profile(id:2, name:"Diego Mendoza", profilePic:"DiegoMendoza",age:"21", heightFeet:"6", heightInch:"0", city:"San Antonio", state:"TX",selfDescription: "Howdy, worked on the swipe cards (what you're looking at right now).", profession: "Student", interest1: "vegan", interest2: "women in tech", interest3: "elcetions", offset: 0),
        Profile(id:3, name:"Francis Zhan", profilePic:"Francis",age:"21", heightFeet:"6", heightInch:"1", city:"Vancouver", state:"BC", selfDescription: "Worked on the swipe screen and UI, when wasn't asleep.", profession: "Software Engineer", interest1: "vegan", interest2: "women in tech", interest3: "elections", offset: 0),
        Profile(id:4, name:"Yash Singh", profilePic:"YashSingh",age:"22", heightFeet:"5", heightInch:"10", city:"New York City", state:"NY", selfDescription: "Worked on chat and inital set up. My favorite game on Houseparty is the drawing one.", profession: "Software Engineer", interest1: "vegan", interest2: "women in tech", interest3: "cars", offset: 0),
        Profile(id:5, name:"Ramses Hernandez", profilePic:"Ramses",age:"21", heightFeet:"5", heightInch:"8", city:"New York", state:"NY", selfDescription: "Worked on backend, mostly at night :) hmu after 1am", profession: "Software Engineer", interest1: "vegan", interest2: "women in tech", interest3: "sitcoms", offset: 0),
        Profile(id:6, name:"Evan Korth", profilePic:"EvanKorth",age:"34", heightFeet:"6", heightInch:"0", city:"New York City", state:"NY", selfDescription: "I am the professor of this class and I totally sanction this.", profession: "Professor", interest1: "vegan", interest2: "rock climbing", interest3: "italian food", offset: 0),
        Profile(id:7, name:"Nolan Filter", profilePic:"NolanFilter",age:"25", heightFeet:"6", heightInch:"1", city:"New York City", state:"NY", selfDescription: "I love Game Design and Batman. I'm also young and tall.", profession: "Game Designer", interest1: "vegan", interest2: "marvel", interest3: "beach", offset: 0),
        Profile(id:8, name:"Neil Patrick Harris", profilePic:"NPH",age:"47", heightFeet:"6", heightInch:"0", city:"Albuquerque", state:"NM", selfDescription: "I am an American actor, singer, comedian, writer, producer, and magician.", profession: "Actor", interest1: "rom coms", interest2: "marvel", interest3: "blockbusters", offset: 0),
        Profile(id:9, name:"Zeve Sanderson", profilePic:"Zeve",age:"33", heightFeet:"5", heightInch:"11", city:"Los Angeles", state:"CA", selfDescription: "I am Judy's boss and did not plan on showing up on this application.", profession: "Boss", interest1: "history", interest2: "music", interest3: "gaming", offset: 0),
//        Profile(id:10, name:"Evan Korth", profilePic:"profilePic",age:"34", heightFeet:"6", heightInch:"0", city:"New York City", state:"CA", selfDescription: "I am the professor of this class and I totally sanction this.", offset: 0),
//        Profile(id:11, name:"Judy Zhang", profilePic:"profilePic",age:"22", heightFeet:"5", heightInch:"4", city:"Los Angeles", state:"CA", selfDescription: "hello!", offset: 0),
//        Profile(id:12, name:"Bing Chen", profilePic:"profilePic",age:"22", heightFeet:"5", heightInch:"3", city:"Brandon", state:"Florida", selfDescription: "Hi!", offset: 0),
//        Profile(id:13, name:"Nolan Filter", profilePic:"profilePic",age:"25", heightFeet:"6", heightInch:"1", city:"New York City", state:"New York", selfDescription: "I am Nolan Filter and I love Game Design!", offset: 0),
//        Profile(id:14, name:"John Johnson", profilePic:"profilePic",age:"35", heightFeet:"6", heightInch:"1", city:"Johnstown", state:"Alaska", selfDescription: "I craft", offset: 0),
    ]
    
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
            GeometryReader{g in
                ZStack{
                    ForEach(self.profiles.reversed()) { p in
                        ProfileView(profile: p, frame: g.frame(in: .global))
                    }
                }
            }
            .padding([.horizontal,.bottom])
        }
        .background(rendezvousYellow.edgesIgnoringSafeArea(.all))

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
                        HStack{
                            Text(profile.interest1)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .background(darkYellow)
                                .cornerRadius(10)
                            Text(profile.interest2)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .background(darkYellow)
                                .cornerRadius(10)
                            Text(profile.interest3)
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .background(darkYellow)
                                .cornerRadius(10)
                        }
                        HStack{
                            Text(profile.profession)
                            Text("•")
                            Text(profile.heightFeet + "'" + profile.heightInch + "\"")
                        }
                        //Text(profile.profession + " , " + profile.heightFeet + "'" + profile.heightInch)
                        Text(profile.selfDescription)
                        .fontWeight(.light)
                    }
                    .foregroundColor(.gray)
                    
                    Spacer(minLength: 0)
                } .padding(.bottom, 5)
                
                HStack(){
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
    var id: Int
//    var firstName: String
//    var lastName: String
    var name: String
    var profilePic: String
//    var gender: String
    var age: String
    var heightFeet: String
    var heightInch: String
    var city: String
    var state: String
    var selfDescription: String
    var profession: String
    var interest1: String
    var interest2: String
    var interest3: String
    var offset: CGFloat

}
