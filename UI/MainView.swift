//
//  SwiftMainView.swift
//  gitsearch (iOS)
//
//  Created by 楊勇 on R 4/02/18.
//

import SwiftUI


struct MainView: View {
    var body: some View {
//        VStack{
//
//         Button("ThrottleUIView") {
//
//          }
//          Button("DebounceUIView") {
//
//          }
//        }
        
        NavigationView {
           
            HStack {
                NavigationLink(destination: ThrottleUIView()) {
                    Text("ThrottleUIView")
//                    Text("DebounceUIView")
                
                }
                NavigationLink(destination: DebounceUIView()) {
//                    Text("ThrottleUIView")
                    Text("DebounceUIView")
                }
            }.navigationBarTitle("")
            
        }
      
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
        }
    }
}
