//
//  ContentView.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/03/15.
//

import SwiftUI
import Firebase

struct MenuItem: Identifiable {
    let id = UUID()
    let name:String
    var quantity:Int
    let imageName:String
    let price:Int
    let shoptype:Int
    var systemNum:Int
}

struct ContentView: View {
    @State var isLoggedIn:Bool = false
    @State var showSheet:Bool = false
    @State var menuresult:Bool = false
    @State var settingIP:String = "//Ip"
    @State var shopString: String = "食券システム"
    @State var shopInt:Int = 0
    @State var menuItems:[MenuItem] =
    [//MenuItem]
    @State var printerIP:String = "IP"
    func resetCart() {
        self.menuItems =
        [//MenuItem]
    }
    var body: some View {
        NavigationStack{
            if isLoggedIn == true {
                if shopString == "食券システム" {
                    if menuresult == false {
                        HStack {
                            EasyEatsMenuView(menuItems: $menuItems, menuResult: $menuresult)
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                NavigationLink {
                                    SettingView(shopString: $shopString, isLoggedIn: $isLoggedIn, settingIP: $settingIP, shopInt: $shopInt)
                                } label: {
                                    Image(systemName: "gearshape")
                                }

                            }
                        }
                    } else {
                        OrderConfirmView(ip: $settingIP, menuResult: $menuresult, shopString: $shopString, cart: $menuItems)
                    }
                } else {
                    if menuresult == false {
                        HStack {
                            MenuView(menuItems: $menuItems, menuResult: $menuresult, shopString: $shopString, shopInt: $shopInt)
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                NavigationLink {
                                    SettingView(shopString: $shopString, isLoggedIn: $isLoggedIn, settingIP: $settingIP, shopInt: $shopInt)
                                } label: {
                                    Image(systemName: "gearshape")
                                }

                            }
                        }
                    } else {
                        OrderConfirmView(ip: $settingIP, menuResult: $menuresult, shopString: $shopString, cart: $menuItems)
                    }
                }
            } else {
                Button(action: {showSheet = true}) {
                    Image("CashRegister")
                        .resizable()
                        .frame(width: 200,height: 200
                        )
                }
                    .navigationTitle("")
            }
        }
        .sheet(isPresented: $showSheet, content: {
            FirebaseLoginView(showSheet: $showSheet, isLoggedIn: $isLoggedIn)}
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPad (8th generation)")
    }
}
