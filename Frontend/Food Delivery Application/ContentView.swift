//
//  ContentView.swift
//  EasyEatsFoodstuffDeliveryApplication
//
//  Created by NaYu on 2023/03/15.
//

import SwiftUI
import Firebase



struct ContentView: View {
    @StateObject var viewModel = FirebaseDatabaseService()
    @State var toolbarViewShow = true
    @State var isLoggedIn:Bool = false
    @State var showSheet:Bool = false
    @State var selectionValue: String = "C"
    var body: some View {
        NavigationStack{
            if isLoggedIn == true {
                    HStack {
                        OrderView(viewModel: viewModel, typeString: $selectionValue)
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink {
                                SettingView(viewModel: viewModel, isLoggedIn: $isLoggedIn)
                            } label: {
                                Image(systemName: "gearshape")
                            }
                            
                        }
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: {
                                selectionValue = "C"
                            }, label: {
                                Text("クレープ")
                            })
                            Spacer()
                            Button(action: {
                                selectionValue = "G"
                            }, label: {
                                Text("焼き鳥")
                            })
                            Spacer()
                            Button(action: {
                                selectionValue = "S"
                            }, label: {
                                Text("フランクフルト")
                            })
                            Spacer()
                            Button(action: {
                                selectionValue = "T"
                            }, label: {
                                Text("たこ焼き")
                            })
                            Spacer()
                            Button(action: {
                                selectionValue = "Y"
                            }, label: {
                                Text("塩焼きそば")
                            })
                        }
                        
                    }
            } else {
                Button(action: {showSheet = true}) {
                    Image("Silverware")
                        .resizable()
                        .frame(width: 200,height: 200
                        )
                }
                    .navigationTitle("")
            }
        }
        .sheet(isPresented: $showSheet, content: {
            FirebaseLoginView(showSheet: $showSheet, isLoggedIn: $isLoggedIn, viewModel: viewModel)}
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isLoggedIn: true)
            .previewDevice("iPad (8th generation)")
    }
}
