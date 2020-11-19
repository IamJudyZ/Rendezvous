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
    
    @State var profiles = [
        
        // Draw the data from firebase
        
        Profile(id: 0, name: "Annie Watson", image: "testPicture", age: "27", offset: 0),
        Profile(id: 1, name: "Clarie", image: "testPicture", age: "19", offset: 0),
        Profile(id: 2, name: "Catherine", image: "testPicture", age: "25", offset: 0),
        Profile(id: 3, name: "Emma", image: "testPicture", age: "26", offset: 0),
        Profile(id: 4, name: "Juliana", image: "testPicture", age: "20", offset: 0),
        Profile(id: 5, name: "Kaviya", image: "testPicture", age: "22", offset: 0),
        Profile(id: 6, name: "Jill", image: "testPicture", age: "18", offset: 0),
        Profile(id: 7, name: "Terasa", image: "testPicture", age: "29", offset: 0),
    ]
    
    var body: some View{
        
        VStack{
            
            HStack(spacing: 15){
                
                Button(action: {}, label: {
                    
                    Image("menu")
                        .renderingMode(.template)
                })
                
                Image("r").resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 20.0, height: 20.0, alignment: .center)

                
                Spacer(minLength: 0)
                
                Button(action: {}, label: {
                    
                    Image("noti")
                        .renderingMode(.template)
                })
            }
            .foregroundColor(.black)
            .padding()

            GeometryReader{g in
                
                ZStack{
                    
                    ForEach(profiles.reversed()){profile in
                        
                        ProfileView(profile: profile,frame: g.frame(in: .global))
                    }
                }
            }
            .padding([.horizontal,.bottom])
        }
        
        
        .background(rendezvousYellow.edgesIgnoringSafeArea(.all))
    }
}


struct ProfileView : View {
    
    @State var profile : Profile
    var frame : CGRect
    
//    self.frame.backgroundColor = UIColor.red
    
    var body: some View{

        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            
            Color.white
            
            Image(profile.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frame.width,height: frame.height, alignment: Alignment(horizontal: .center, vertical: .center))
           
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                
                (profile.offset > 0 ? Color.green : Color("Color"))
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

//            LinearGradient(gradient: .init(colors: [Color.black.opacity(0),Color.black.opacity(0.4)]), startPoint: .center, endPoint: .bottom)
            
            VStack(spacing: 20){
                
                HStack{
                    
                    VStack(alignment: .leading,spacing: 12){
                        
                        Text(profile.name)
                            .font(.title)
                            .fontWeight(.bold).foregroundColor(.white)
                        
                        Text(profile.age + " +")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                }
                
                HStack(spacing: 35){
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                        withAnimation(Animation.easeIn(duration: 0.8)){
                            
                            profile.offset = -500
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
                        
                        withAnimation(Animation.easeIn(duration: 0.8)){
                            
                            profile.offset = 500
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
                    
                    withAnimation(.default){
                    
                        profile.offset = value.translation.width
                    }
                })
                .onEnded({ (value) in
                    
                    withAnimation(.easeIn){
                    
                        if profile.offset > 150{
                            
                            profile.offset = 500
                        }
                        else if profile.offset < -150{
                            
                            profile.offset = -500
                        }
                        else{
                            
                            profile.offset = 0
                        }
                    }
                })
        )
    }
}

struct Profile : Identifiable {
    
    var id : Int
    var name : String
    var image : String
    var age : String
    var offset : CGFloat
}
