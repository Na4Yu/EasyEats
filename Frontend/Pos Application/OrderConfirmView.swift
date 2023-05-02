//
//  OrderConfirmView.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/04/21.
//

import SwiftUI
import Firebase

struct OrderConfirmView: View {
    @State var price:Int = 0
    @State var pushed:Bool = false
    @State var printReady:Bool = false
    @State var orderString:String = ""
    @State private var alertM:Bool = false
    @State private var errorMessage = ""
    @Binding var ip:String
    @Binding var menuResult:Bool
    @Binding var shopString:String
    @Binding var cart:[MenuItem]
    var body: some View {
        VStack {
            HStack{
                List(cart.filter { $0.quantity > 0}) { menuItem in
                    Text("食券番号: \(menuItem.systemNum)    \(menuItem.name) × \(menuItem.quantity)  合計:\(menuItem.quantity * menuItem.price)円")
                }
            }
            if (shopString == "食券システム") {
                Text("注文識別キー = \(orderString)")
                Text("食券番号が0の場合は未取得です。")
                    .font(.system(size: 26))
            }
            Text("合計金額: \(price)円")
                .font(.system(size: 30))
            
            HStack{
                Spacer()
                if pushed == false {
                    Button {
                        menuResult = false
                    } label: {
                        Image(systemName: "arrow.uturn.backward", variableValue: 1.00)
                            .resizable()
                            .symbolRenderingMode(.monochrome)
                            .foregroundColor(Color.accentColor)
                            .font(.system(size: 16))
                            .frame(width: 80, height: 80)
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(20)
                    }
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                if (shopString == "食券システム") {
                    if pushed == false {
                        Button {
                            pushOrder(order: easyeatsOrder(c1: cart[0].quantity, c2: cart[1].quantity, g1: cart[2].quantity, s1: cart[3].quantity, t1: cart[4].quantity, y1: cart[5].quantity)) { orderKey in
                                guard let orderKey = orderKey else {
                                    print("Error: Failed to push order")
                                    errorMessage = "Error: Failed to push order"
                                    alertM = true
                                    return
                                }
                                self.orderString = orderKey
                                pushed = true
                            }
                        } label: {
                            Image(systemName: "cart.circle", variableValue: 1.00)
                                .resizable()
                                .symbolRenderingMode(.monochrome)
                                .foregroundColor(Color.accentColor)
                                .font(.system(size: 16, weight: .regular))
                                .frame(width: 80, height: 80)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(20)
                        }
                    } else {
                            Button {
                                if (cart[0].quantity + cart[1].quantity != 0) {
                                    searchOrderkey(orderKey: orderString, in: Database.database().reference(withPath: "tickets/keylist/c")) { snapshot in
                                        guard let snapshot = snapshot else {
                                            return
                                        }
                                        print(snapshot)
                                        if let keynumValue = snapshot.value as? [String: Any], let keynum = keynumValue["keynum"] as? Int {
                                            cart[0].systemNum = keynum
                                            cart[1].systemNum = keynum
                                        } else {
                                            errorMessage = "DB側型エラー"
                                        }
                                    }
                                } else {
                                    cart[0].systemNum = 1
                                    cart[1].systemNum = 1
                                }
                                if (cart[2].quantity != 0) {
                                    searchOrderkey(orderKey: orderString, in: Database.database().reference(withPath: "tickets/keylist/g")) { snapshot in
                                        guard let snapshot = snapshot else {
                                            return
                                        }
                                        print(snapshot)
                                        if let keynumValue = snapshot.value as? [String: Any], let keynum = keynumValue["keynum"] as? Int {
                                            cart[2].systemNum = keynum
                                        } else {
                                            errorMessage = "DB側型エラー"
                                        }
                                    }
                                } else {
                                    cart[2].systemNum = 1
                                }
                                if (cart[3].quantity != 0) {
                                    searchOrderkey(orderKey: orderString, in: Database.database().reference(withPath: "tickets/keylist/s")) { snapshot in
                                        guard let snapshot = snapshot else {
                                            return
                                        }
                                        print(snapshot)
                                        if let keynumValue = snapshot.value as? [String: Any], let keynum = keynumValue["keynum"] as? Int {
                                            cart[3].systemNum = keynum
                                        } else {
                                            errorMessage = "DB側型エラー"
                                        }
                                    }
                                } else {
                                    cart[3].systemNum = 1
                                }
                                if (cart[4].quantity != 0) {
                                    searchOrderkey(orderKey: orderString, in: Database.database().reference(withPath: "tickets/keylist/t")) { snapshot in
                                        guard let snapshot = snapshot else {
                                            return
                                        }
                                        print(snapshot)
                                        if let keynumValue = snapshot.value as? [String: Any], let keynum = keynumValue["keynum"] as? Int {
                                            cart[4].systemNum = keynum
                                        } else {
                                            errorMessage = "DB側型エラー"
                                        }
                                    }
                                } else {
                                    cart[4].systemNum = 1
                                }
                                if (cart[5].quantity != 0) {
                                    searchOrderkey(orderKey: orderString, in: Database.database().reference(withPath: "tickets/keylist/y")) { snapshot in
                                        guard let snapshot = snapshot else {
                                            return
                                        }
                                        print(snapshot)
                                        if let keynumValue = snapshot.value as? [String: Any], let keynum = keynumValue["keynum"] as? Int {
                                            cart[5].systemNum = keynum
                                        } else {
                                            errorMessage = "DB側型エラー"
                                        }
                                    }
                                } else {
                                    cart[5].systemNum = 1
                                }
                                if (cart[0].systemNum != 0 && cart[1].systemNum != 0 && cart[2].systemNum != 0 && cart[3].systemNum != 0 && cart[4].systemNum != 0 && cart[5].systemNum != 0) {
                                    TicketPDFHandler(orderkey: orderString, c1: cart[0].quantity, c2: cart[1].quantity, cnum: cart[0].systemNum, g1: cart[2].quantity, gnum: cart[2].systemNum, s1: cart[3].quantity, s2: 0, snum: cart[3].systemNum, t1: cart[4].quantity, tnum: cart[4].systemNum, y1: cart[5].quantity, ynum: cart[5].systemNum) { pdfpath in
                                        guard let pdfpath = pdfpath else {
                                            errorMessage = "印刷エラー"
                                            alertM = true
                                            return
                                        }
                                        print(pdfpath)
                                        let resultmessage = printPDF(path: pdfpath, ip: "172.16.15.246")
                                        print("trororor")
                                        errorMessage = resultmessage
                                        alertM = true
                                    }
                                }
                            } label: {
                                Image(systemName: "ticket.fill", variableValue: 1.00)
                                    .resizable()
                                    .symbolRenderingMode(.monochrome)
                                    .foregroundColor(Color.accentColor)
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(width: 80, height: 80)
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .cornerRadius(20)
                            }
                        Spacer()
                            Button {
                                payBySquare(price: price, store: shopString, method: .cash) { result in
                                    guard let result = result else {
                                        errorMessage = "決済エラー"
                                        return
                                    }
                                    if result == true {
                                        cart =
                                        [//MenuItem]
                                        menuResult = false
                                    } else {
                                        errorMessage = "決済エラー"
                                        return
                                    }
                                }
                            } label: {
                                Image(systemName: "banknote", variableValue: 1.00)
                                    .resizable()
                                    .symbolRenderingMode(.monochrome)
                                    .foregroundColor(Color.accentColor)
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(width: 80, height: 60)
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .cornerRadius(20)
                            }
                            Button {
                                payBySquare(price: price, store: shopString, method: .card) { result in
                                    guard let result = result else {
                                        errorMessage = "決済エラー"
                                        return
                                    }
                                    if result == true {
                                        cart =
                                        [//MenuItem]
                                        menuResult = false
                                    } else {
                                        errorMessage = "決済エラー"
                                        return
                                    }
                                }
                            } label: {
                                Image(systemName: "creditcard", variableValue: 1.00)
                                    .resizable()
                                    .symbolRenderingMode(.monochrome)
                                    .foregroundColor(Color.accentColor)
                                    .font(.system(size: 16, weight: .regular))
                                    .frame(width: 80, height: 60)
                                    .padding()
                                    .background(Color(.systemGray5))
                                    .cornerRadius(20)
                            }
                    }
                    Spacer()
                } else {
                    HStack {
                        Button {
                            payBySquare(price: price, store: shopString, method: .cash) { result in
                                guard let result = result else {
                                    errorMessage = "決済エラー"
                                    return
                                }
                                if result == true {
                                    cart =
                                    [//MenuItem]
                                    menuResult = false
                                } else {
                                    errorMessage = "決済エラー"
                                    return
                                }
                            }
                        } label: {
                            Image(systemName: "banknote", variableValue: 1.00)
                                .resizable()
                                .symbolRenderingMode(.monochrome)
                                .foregroundColor(Color.accentColor)
                                .font(.system(size: 16, weight: .regular))
                                .frame(width: 80, height: 60)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(20)
                        }
                        Button {
                            payBySquare(price: price, store: shopString, method: .card) { result in
                                guard let result = result else {
                                    errorMessage = "決済エラー"
                                    return
                                }
                                if result == true {
                                    cart =
                                    [//MenuItem]
                                    menuResult = false
                                } else {
                                    errorMessage = "決済エラー"
                                    return
                                }
                            }
                        } label: {
                            Image(systemName: "creditcard", variableValue: 1.00)
                                .resizable()
                                .symbolRenderingMode(.monochrome)
                                .foregroundColor(Color.accentColor)
                                .font(.system(size: 16, weight: .regular))
                                .frame(width: 80, height: 60)
                                .padding()
                                .background(Color(.systemGray5))
                                .cornerRadius(20)
                        }
                    }
                }
                Spacer()
            }
        }
        .onAppear{
            var finalprice:Int = 0
            for obj in cart {
                finalprice = finalprice + (obj.quantity * obj.price)
            }
            self.price = finalprice
        }
        .alert(isPresented: $alertM) {
            Alert(title: Text(errorMessage))
        }
    }
}

