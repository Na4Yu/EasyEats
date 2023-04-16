//
//  SettingView.swift
//  EasyEatsFoodstuffDeliveryApplication
//
//  Created by NaYu on 2023/04/08.
//

import SwiftUI
import Firebase

struct SettingView: View {
    @State var loginUser:String = ""
    @State var errorMessage:String = ""
    @State private var kitchenSelection: String = ""
    @ObservedObject var viewModel:FirebaseDatabaseService
    @Binding var isLoggedIn:Bool
    @Environment(\.dismiss) private var dismiss
    var body: some View {
            VStack {
                Spacer()
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
                        viewModel.removeObservers()
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
        SettingView(viewModel: FirebaseDatabaseService(), isLoggedIn: .constant(false))
    }
}
