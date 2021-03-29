//
//  LoginPage.swift
//  Triviastic
//
//  Created by Moni Manolov on 07/03/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct LoginPage: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: .init(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
                

                Home()
            }
        }
        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

struct Home: View {
    @State var index = 0
    
    var body: some View{

        VStack{
            Image("TriviasticLogo")
                .frame(width: 200, height: 200)
            
            HStack{
                Button(action:{
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        self.index = 0
                    }
                    
                })
                {
                    Text("Existing")
                        .foregroundColor(self.index == 0 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .frame(width:(UIScreen.main.bounds.width - 50)/2)
                }
                .background(self.index == 0 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
                Button(action:{
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)){
                        self.index = 1
                    }
                })
                {
                    Text("New")
                        .foregroundColor(self.index == 1 ? .black : .white)
                        .fontWeight(.bold)
                        .padding(.vertical,10)
                        .frame(width:(UIScreen.main.bounds.width - 50)/2)
                }
                .background(self.index == 1 ? Color.white : Color.clear)
                .clipShape(Capsule())
                
            }
            
            .background(Color.black.opacity(0.1))
            .clipShape(Capsule())
            .padding(.top,25)
            
            if self.index == 0{
                Login()
            }
            else{
                Register()
            }
            
        }
        .padding()
        
    }
}

struct Login : View{
    @State var email = ""
    @State var password = ""
    @State private var isShowingMenu = false

    var body: some View{

        VStack{
        VStack{
            HStack(spacing:15){
                Image(systemName: "eye")
                    .foregroundColor(.black)

                TextField("Enter email address", text: self.$email)}
                    .padding(.vertical,20)

                Divider()

            
            HStack(spacing:15){
                Image(systemName: "lock")
                    .resizable()
                    .frame(width:15,height: 18)
                    .foregroundColor(.black)

                SecureField("Enter password", text: self.$password)
                
                Button(action: {
                    
                }){
                    Image(systemName: "eye")
                        .foregroundColor(.black)
                }
            }.padding(.vertical,20)
           
            
            }
        .padding(.vertical)
        .padding(.horizontal,30)
        .padding(.bottom,20)
        .background(Color.white)
        .cornerRadius(30)
        .padding(.top,25)
    
        }
        NavigationLink(
            destination: MenuPageView(),
            isActive: $isShowingMenu,
            label: {Button(action:
                            {
                                print("predi")
                                login(email,password)
                                print("sled")
                                if((UserDefaults.standard.string(forKey: "uuid") ?? "") != ""){
                                print("Succes!")
                                    self.email = ""
                                    self.password = ""
                                isShowingMenu.toggle()
                            }
                                
                                }, label: {
                                Text("Login")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding(.vertical)
                                    .frame(width: UIScreen.main.bounds.width-100)
                
                
            }
            )}
        )
    
//        Button(action:{
//
//            login(email,password)
//
//
//        }){
//            Text("Login")
//                .foregroundColor(.white)
//                .fontWeight(.bold)
//                .padding(.vertical)
//                .frame(width: UIScreen.main.bounds.width-100)
//
//        }
        .background(
            LinearGradient(gradient: .init(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
        )
        .cornerRadius(20)
        .offset(y: -40)
        .padding(.bottom, -40)
        .shadow(radius: 15)
        
    }
    
    }


struct Register : View{
    @State var email = ""
    @State var password = ""
    @State var rePassword = ""
    @State private var isShowingMenu = false

    var body: some View{

        VStack{
        VStack{
            HStack(spacing:15){
                Image(systemName: "eye")
                    .foregroundColor(.black)

                TextField("Enter email address", text: self.$email)}
                    .padding(.vertical,20)

                Divider()

            
            HStack(spacing:15){
                Image(systemName: "lock")
                    .resizable()
                    .frame(width:15,height: 18)
                    .foregroundColor(.black)

                SecureField("Enter password", text: self.$password)
                
                Button(action: {
                    
                }){
                    Image(systemName: "eye")
                        .foregroundColor(.black)
                }
            }.padding(.vertical,20)
            
            Divider()
            
            HStack(spacing:15){
                Image(systemName: "lock")
                    .resizable()
                    .frame(width:15,height: 18)
                    .foregroundColor(.black)

                SecureField("Confirm password", text: self.$rePassword)
                
                Button(action: {
                    
                }){
                    Image(systemName: "eye")
                        .foregroundColor(.black)
                }
            }.padding(.vertical,20)
           
            
            }
        .padding(.vertical)
        .padding(.horizontal,30)
        .padding(.bottom,40)
        .background(Color.white)
        .cornerRadius(30)
        .padding(.top,25)
    
        }
        
        NavigationLink(
            destination: MenuPageView(),
            isActive: $isShowingMenu,
            label: {Button(action:
                            {
                                register(email,password,rePassword)
                                    isShowingMenu.toggle()
                                self.email = ""
                                self.password = ""
                                self.rePassword = ""
                                
                                }, label: {
                                Text("Register")
                                    .foregroundColor(.white)
                                                   .fontWeight(.bold)
                                                   .padding(.vertical)
                                                   .frame(width: UIScreen.main.bounds.width-100)
                                    .background(
                                                LinearGradient(gradient: .init(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                                            )
                                            .cornerRadius(8)
                                            .offset(y: -40)
                                            .padding(.bottom, -40)
                                            .shadow(radius: 15)
                
            }
                                
            )}
        
        )
        
//        Button(action:{
////          let newUser = register(email,password,rePassword)
////            let defaults = UserDefaults.standard
////            defaults.setCodableObject(newUser, forKey: "user")
//
//            register(email,password,rePassword)
//
//        }){
//            Text("Register")
//                .foregroundColor(.white)
//                .fontWeight(.bold)
//                .padding(.vertical)
//                .frame(width: UIScreen.main.bounds.width-100)
//
//        }
//        .background(
//            LinearGradient(gradient: .init(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
//        )
//        .cornerRadius(8)
//        .offset(y: -40)
//        .padding(.bottom, -40)
//        .shadow(radius: 15)
        
    }
    
    }

func login(_ email: String,_ password: String) {
    print("login")
    Auth.auth().signIn(withEmail: email , password: password) {  authResult, error in
            guard authResult != nil
            else {
            print("wrong credentials")
            return
            }
            
            let db = Firestore.firestore()

            db.collection("users").document(Auth.auth().currentUser!.uid).getDocument(){(document, error) in
                if let document = document, document.exists {
                    let user = User(snapshot: document)
                UserDefaults.standard.setValue(document.documentID, forKey: "uuid")
                print(document.documentID)
                              UserDefaults.standard.setCodableObject(user, forKey: "user")
                UserDefaults.standard.setValue(user.isAdmin, forKey: "isAdmin")
                
               
                
                
               
        }
        
}
    
    
}
    
   
}
func register(_ email: String,_ password: String,_ rePassword: String){
    print("register")
    if(password != rePassword){
        print("Confirm password dosn't match")
        return
    }
    
    if(password.count<6){
        print("Please provide password longer  than 5 symbols")
        return
    }
    
    Auth.auth().createUser(withEmail: email, password: password){ authResult, error in
        guard authResult != nil else{
            print(error ?? "an error has occured")
            return
        }
        
        let db = Firestore.firestore()
        
        let data: [String: Any] = [
            "email": email,
            "connections": [],
            "points": 0,
            "isAdmin": false
        ]
        
                do {
                     db.collection("users").document(Auth.auth().currentUser!.uid).setData(data)
        
                } catch let error {
                    print("Error writing city to Firestore: \(error)")
                }
                
                
            }

    }


