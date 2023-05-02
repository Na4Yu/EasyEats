//
//  PrivateLoginView.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/04/24.
//

import SwiftUI

struct PrivateLoginView: View {
    @State private var enteredDigits = ["","","",""]
    @State private var digits:Int = 0
    @Binding var showadvancedsettings:Bool
    @Binding var showthisview:Bool
    func digitButtonPressed(_ digit: Int) {
        if (digits < 4) {
            enteredDigits[digits] = "\(digit)"
            digits = digits + 1
        }
    }
    func cleardigits() {
        self.enteredDigits = ["","","",""]
        self.digits = 0
    }
    func checkdigits() {
        if (self.enteredDigits == ["6","5","5","8"]) {
            self.showadvancedsettings = true
            self.showthisview = false
            print("ll")
        }
    }
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("\(enteredDigits[0])")
                    .font(.system(size: 40))
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
                Text("\(enteredDigits[1])")
                    .font(.system(size: 40))
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
                Text("\(enteredDigits[2])")
                    .font(.system(size: 40))
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
                Text("\(enteredDigits[3])")
                    .font(.system(size: 40))
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
                Spacer()
            }
            Spacer()
            ForEach(1...3, id: \.self) { row in
                HStack {
                    ForEach(row*3-2...row*3, id: \.self) { digit in
                        Button {
                            digitButtonPressed(digit)
                        } label: {
                            Text("\(digit)")
                                .font(.system(size:50))
                        }
                        .frame(width: 60, height: 60)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(20)
                    }
                }
            }
            HStack(alignment: .center) {
                Spacer()
                Button {
                    cleardigits()
                } label: {
                    Image(systemName: "clear", variableValue: 1.00)
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 44, weight: .regular))
                }
                .frame(width: 60, height: 60)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                Button {
                    digitButtonPressed(0)
                } label: {
                    Text("0")
                        .font(.system(size: 50))
                }
                .frame(width: 60, height: 60)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                Button {
                    checkdigits()
                } label: {
                    Image(systemName: "arrow.right.to.line", variableValue: 1.00)
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(Color.accentColor)
                    .font(.system(size: 42, weight: .regular))
                }
                .frame(width: 60, height: 60)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(20)
                Spacer()
            }
            Spacer()
        }
    }
}

struct PrivateLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PrivateLoginView(showadvancedsettings: .constant(true), showthisview: .constant(false))
    }
}
