//
//  LeaderboardPage.swift
//  Triviastic
//
//  Created by Moni Manolov on 10/03/2021.
//

import SwiftUI

struct LeaderboardPage: View {
    var body: some View {
      
        ZStack{
            LinearGradient(gradient: .init(colors: [Color.red, Color.blue]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all)
            
            LeaderBoard()
        }
    }
}

struct LeaderboardPage_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardPage()
    }
}

struct LeaderBoard: View{
    var body: some View{
        GeometryReader{ geometry in
        VStack{
            VStack{
            HStack{
            Text("1.")
                .foregroundColor(.black)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            Image(systemName: "person.crop.square")
                .resizable()
                .frame(width: 40, height: 40)
            Text("First player")                    .foregroundColor(.black)
                  .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                  
            }
                Text("<points>")
            }
            .frame(width:geometry.size.width * 0.80, height: 100)
            .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
            .padding([.leading,.trailing],38)
            
            
            VStack{
            HStack{
            Text("2.")
                .foregroundColor(.black)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            Image(systemName: "person.crop.square")
                .resizable()
                .frame(width: 40, height: 40)
            Text("Second player")                    .foregroundColor(.black)
                  .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                  
            }
                Text("<points>")
            }
            .frame(width:geometry.size.width * 0.80, height: 100)
            .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
            .padding([.leading,.trailing],38)
            
            VStack{
            HStack{
            Text("3.")
                .foregroundColor(.black)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            Image(systemName: "person.crop.square")
                .resizable()
                .frame(width: 40, height: 40)
            Text("Third player")                    .foregroundColor(.black)
                  .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                  
            }
                Text("<points>")
            }
            .frame(width:geometry.size.width * 0.80, height: 100)
            .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
            .padding([.leading,.trailing],38)
            
            ZStack{
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(4..<30) {
                        Text("\($0). <Player name> - 3132 points")
                    }
                }
            }
            }
            .padding(.bottom,20)
            .padding(.top,40)
        }
            
            }

    }
}
