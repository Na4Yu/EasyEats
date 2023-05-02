//
//  SettingView.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/04/21.
//

import SwiftUI
import Firebase

struct SettingView: View {
    @State var loginUser = ""
    @State var errorMessage:String = ""
    @State var advancedsettings:Bool = false
    @State var showadvancedsettings:Bool = false
    @Binding var shopString:String
    @Binding var isLoggedIn:Bool
    @Binding var settingIP:String
    @Binding var shopInt:Int
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        if !showadvancedsettings {
            VStack {
                Spacer()
                Button {
                    advancedsettings = true
                } label: {
                    Text("高度な設定")
                        .font(.system(size: 30))
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
                Button {
                    do {
                        try Auth.auth().signOut()
                        isLoggedIn = false
                        dismiss()
                    }
                    catch let error as NSError {
                        errorMessage = error as! String
                    }
                } label: {
                    Text("ログアウト")
                        .font(.system(size: 30))
                }
                Spacer()
            }
            .onAppear{
                if let user = Auth.auth().currentUser {
                    loginUser = user.email ?? "未ログイン"
                }
                print(showadvancedsettings)
            }
            .sheet(isPresented: $advancedsettings) {
                PrivateLoginView(showadvancedsettings: $showadvancedsettings, showthisview: $advancedsettings)
            }
        } else {
            AdvancedSettingView(shopString: $shopString, settingIp: $settingIP, shopInt: $shopInt)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(shopString: .constant("食券システム"), isLoggedIn: .constant(true), settingIP: .constant("172.16.15.240"), shopInt: .constant(0))
    }
}
