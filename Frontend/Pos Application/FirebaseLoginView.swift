//
//  FirebaseLoginView.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/03/15.
//

import SwiftUI
import FirebaseAuth

struct FirebaseLoginView: View {
    @State public var mail:String = ""
    @State public var password:String = ""
    @State public var errorMessage:String = ""
    @State var textfieldmail = String()
    @State private var alertM:Bool = false
    @State private var onEditing:Bool = false
    @Binding var showSheet:Bool
    @Binding var isLoggedIn:Bool
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0) {
                Rectangle()
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                    .frame(height: geometry.size.height * 0.1)
                Form {
                    Section {
                        VStack (alignment: .leading){
                            HStack {
                                TextField("メールアドレス",text: $textfieldmail)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: textfieldmail) { newvalue in
                                        mail = newvalue + "Mail"
                                    }
                                Text("Mail")
                            }
                            .padding(.bottom)
                            SecureField("パスワード",text:$password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        .padding()
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button(
                                action:{
                                    if(self.mail == ""){
                                        errorMessage = "メールアドレスが入力されていません"
                                        alertM = true
                                    } else if(self.password == ""){
                                        errorMessage = "パスワードが入力されていません"
                                        alertM = true
                                    } else {
                                        
                                        Auth.auth().signIn(withEmail: mail, password: password, completion: { (auth, error) in
                                            if let maybeError = error {
                                                let err = maybeError as NSError
                                                switch err.code {
                                                case AuthErrorCode.wrongPassword.rawValue:
                                                    errorMessage = ("パスワードが違います。")
                                                    alertM = true
                                                case AuthErrorCode.invalidEmail.rawValue:
                                                    errorMessage = ("メールが間違っています")
                                                    alertM = true
                                                case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                                                    errorMessage = ("アカウントが別のIDで登録されています")
                                                    alertM = true
                                                default:
                                                    errorMessage = ("不明なエラー: \(err.localizedDescription)")
                                                    alertM = true
                                                }
                                            } else {
                                                if let _ = auth?.user {
                                                    showSheet = false
                                                    isLoggedIn = true
                                                } else {
                                                    errorMessage = ("未ログイン")
                                                    alertM = true
                                                }
                                            }
                                        })
                                    }
                                }, label:{
                                    Text("ログイン")
                                })
                            Spacer()
                        }
                    }
                }
                .alert(isPresented: $alertM) {
                    Alert(title: Text(errorMessage))
                }
                Rectangle()
                    .foregroundColor(Color(UIColor.systemGroupedBackground))
                    .frame(height: geometry.size.height * 0.1)
            }
        }
    }
}

struct FirebaseLoginView_Previews: PreviewProvider {
    static var previews: some View {
        FirebaseLoginView(showSheet : .constant(true), isLoggedIn: .constant(false))
    }
}
