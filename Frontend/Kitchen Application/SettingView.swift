//
//  SettingView.swift
//  EasyEatsKitchenTableApplication
//
//  Created by NaYu on 2023/03/26.
//

import SwiftUI
import Firebase

struct SettingView: View {
    @State var loginUser:String = ""
    @State var errorMessage:String = ""
    @State private var kitchenSelection: String = ""
    @ObservedObject var viewModel:FirebaseDatabaseService
    @Binding var isLoggedIn:Bool
    @Binding var selectionValue:String
    @State private var listElements = ["クレープ","焼き鳥","フランクフルト","たこ焼き","塩焼きそば"]
    @Environment(\.dismiss) private var dismiss
    var body: some View {
            VStack {
                Spacer()
                Spacer()
                VStack {
                    if viewModel.adminUser == true {
                        Text("管理者権限")
                            .font(.system(size:25))
                        Picker(selection: $selectionValue, label: Text("店舗"), content: {
                            ForEach(listElements, id:\.self) { value in
                                Text("\(value)") 
                                    .tag(value)
                            }
                        })
                        .onChange(of: selectionValue) { newValue in
                            switch newValue {
                            case "クレープ":
                                kitchenSelection = "tickets/C/orders"
                            case "焼き鳥":
                                kitchenSelection = "tickets/G/orders"
                            case "フランクフルト":
                                kitchenSelection = "tickets/S/orders"
                            case "たこ焼き":
                                kitchenSelection = "tickets/T/orders"
                            case "塩焼きそば":
                                kitchenSelection = "tickets/Y/orders"
                            default:
                                kitchenSelection = "tickets/C/orders"
                            }
                            viewModel.changeRef(to: kitchenSelection)
                        }
                    } else {
                        Text("店舗名: \(viewModel.shopName)")
                            .font(.system(size:30))
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 50,height: 50)
                    Text("Logged in as \(loginUser)")
                        .font(.system(size:25))
                    Spacer()
                }
                Spacer()
                Button("ログアウト") {
                    do {
                        try Auth.auth().signOut()
                        viewModel.logoutRef()
                        viewModel.adminUser = false
                        isLoggedIn = false
                        dismiss()
                    }
                    catch let error as NSError {
                        errorMessage = error as! String
                    }
                }
                Spacer()
                Spacer()
        }
        .onAppear{
            if let user = Auth.auth().currentUser {
                loginUser = user.email ?? "未ログイン"
                
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(viewModel: FirebaseDatabaseService(), isLoggedIn: .constant(false), selectionValue: .constant("クレープ"))
    }
}
