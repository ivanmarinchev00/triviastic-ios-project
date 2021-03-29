//
//  MenuPageView.swift
//  Triviastic
//
//  Created by Ivan Marinchev on 3/7/21.
//

import SwiftUI

struct MenuPageView: View {
 
    
    
    @State private var isAdmin = UserDefaults.standard.bool(forKey: "isAdmin")
    @State private var isShowingNewGame = false
    @State private var isShowingAddQuestions = false
    @State private var currentView = ""
    @State private var isShowingLeaderboard = false
    
    
    var body: some View {
        NavigationView{
            
            GeometryReader{ geometry in
                
                LinearGradient(gradient: .init(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
                
                VStack{
                    
                   
                    
                    Image("TriviasticLogo")
                        .frame(width: geometry.size.width * 0.50, height: geometry.size.height * 0.25, alignment: .center)
//                    Button("Continue Game") {
//                        
//                    }
//                        .foregroundColor(.white)
//                        .frame(width: geometry.size.width * 0.50, height: geometry.size.height * 0.03, alignment: Alignment.center)
//                        .padding()
//                        .background(Color.accentColor)
//                        .cornerRadius(8)
//                    .padding()
                    
                    NavigationLink(
                        destination: GamePageView(image: ""),
                        isActive: $isShowingNewGame,
                        label: {
                            Text("Start Game")
                                .foregroundColor(.white)
                            .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.08, alignment: Alignment.center)
                                .background(Color.accentColor)
                                .cornerRadius(8)
                                .padding()
                            
                        }
                        
                    )
                                    
                    
                    if !self.isAdmin{
                        NavigationLink(
                            destination: GamePageView(image: ""),
                            isActive: $isShowingNewGame,
                            label: {Button(action: {isShowingNewGame.toggle()}, label: {Text("Manage Questions")
                                            .foregroundColor(.white)
                                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.08, alignment: Alignment.center)
                                            .background(Color.accentColor)
                                            .cornerRadius(8)
                                            .padding()})
                                
                                
                            }
                            
                        )                    } else{
                        NavigationLink(
                            destination: LeaderboardPage(),
                            isActive: $isShowingLeaderboard,
                            label: {Button(action: {isShowingLeaderboard.toggle()}, label: {Text("Leaderboard")
                                            .foregroundColor(.white)
                                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.08, alignment: Alignment.center)
                                            .background(Color.accentColor)
                                            .cornerRadius(8)
                                            .padding()})
                                
                                
                            }
                            
                        )                    }
                    
                    NavigationLink(
                        destination: AddQuestionView(),
                        isActive: $isShowingAddQuestions,
                        label: {Button(action: {isShowingAddQuestions.toggle()}, label: {Text("Add Question")
                                        .foregroundColor(.white)
                                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.08, alignment: Alignment.center)
                                        .background(Color.accentColor)
                                        .cornerRadius(8)
                                        .padding()})
                            
                            
                        }
                        
                    )

                }
                
                .frame(width: geometry.size.width * 1, height: geometry.size.height * 1, alignment: .center)
                
                
            }
            
            
            
            
            
        }
        .navigationBarHidden(true)

        
        
        
        
        }
   
    
        
        
    
    
    //
}

struct MenuPageView_Previews: PreviewProvider {
    static var previews: some View {
        MenuPageView()
    }
}
