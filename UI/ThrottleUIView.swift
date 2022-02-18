//
//  ThrottleUIView.swift
//  gitsearch (iOS)
//
//  Created by 楊勇 on R 4/02/18.
//

import SwiftUI

struct ThrottleUIView: View {
    @State private var searchText = ""
    let throttleAction = DispatchQueue.global().throttle(delay: .milliseconds(500))
    @State var retResponseString :String = "";
    @State var  items: [GithubSearch.Model] = [];
    var body: some View {
        VStack {
            Text("You entered: \(searchText)")
                .padding()
                
            TextField("Enter Something", text: $searchText)
                .frame(height: 30)
                .padding(.leading, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.blue, lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .onChange(of: searchText, perform: { _ in
                    
                    throttleAction { [self] in
                    
                        print(searchText)
                        GithubSearch.search(term: searchText){ [self] result in
                            switch (result) {
                            case .success(let res):
                                    if(res.total_count > 0){
                                        for m in res.items {
                                            var fullname = m.full_name
                                            print("fullname: \(fullname)")
                                            retResponseString += fullname
                                            retResponseString += "\n"
                                            print("retResponseString: \(retResponseString)")
                                        }
                                        items = res.items
                                    }
                                break
                            case .failure(let error):
                                    retResponseString = String(error.localizedDescription)
                                break
                            }
                        }
                    }

                })
//            Text("Result:\n \(retResponseString)")
//                .foregroundColor(.red)
//                .padding(.leading, 5)
//                .padding(.horizontal, 20)
//                .multilineTextAlignment(.leading)
//                .lineLimit(nil)
                
            List(items) { mItem in
                Text(mItem.full_name)
            }

        }
        
    }
}

struct ThrottleUIView_Previews: PreviewProvider {
    static var previews: some View {
        ThrottleUIView()
    }
}
