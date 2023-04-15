//
//  ContentView.swift
//  EasyEatsKitchenTableApplication
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
    @State var selectionValue: String = "クレープ"
    var body: some View {
        NavigationStack{
            if isLoggedIn == true {
                GeometryReader { geometry in
                    HStack {
                        OrderListView(viewModel: viewModel)
                            .frame(width: geometry.size.width * 0.7)
                        TradeConsoleView(viewModel: viewModel)
                            .frame(width: geometry.size.width * 0.3)
                    }
                }
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            NavigationLink {
                                SettingView(viewModel: viewModel, isLoggedIn: $isLoggedIn, selectionValue: $selectionValue)
                            } label: {
                                Image(systemName: "gearshape")
                            }
                            
                        }
                    }
            } else {
                Button(action: {showSheet = true}) {
                    Image("Spatula")
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
