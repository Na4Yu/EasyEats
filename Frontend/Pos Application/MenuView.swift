//
//  MenuView.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/03/15.
//

import SwiftUI
import Firebase

struct MenuView: View {
    @Binding var menuItems:[MenuItem]
    @Binding var menuResult:Bool
    @Binding var shopString:String
    @Binding var shopInt:Int
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack {
                    ScrollView(.vertical) {
                        ForEach(menuItems.indices, id: \.self) { index in
                            if (menuItems[index].shoptype == shopInt) {
                                HStack {
                                    VStack {
                                        if (menuItems[index].imageName == "0") {
                                            Image(uiImage: UIImage(named: "PayOut")!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 150, height: 150)
                                        } else {
                                            Image(uiImage: UIImage(named:menuItems[index].imageName)!)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 150, height: 150)
                                        }
                                        Text(menuItems[index].name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                    .frame(width: 260, height: 300)
                                    VStack {
                                        Spacer()
                                        Button {
                                            menuItems[index].quantity += 1
                                        } label: {
                                            Image(systemName: "plus")
                                                .resizable()
                                                .symbolRenderingMode(.monochrome)
                                                .foregroundColor(.accentColor)
                                                .frame(width: 40,height: 40)
                                        }
                                        .frame(width: 70, height: 70, alignment: .center)
                                        .background(Color(.systemGray5))
                                        .cornerRadius(20)
                                        Spacer()
                                        Button {
                                            if menuItems[index].quantity > 0 {
                                                menuItems[index].quantity -= 1
                                            }
                                        } label: {
                                            Image(systemName: "minus")
                                                .resizable()
                                                .symbolRenderingMode(.monochrome)
                                                .foregroundColor(.accentColor)
                                                .frame(width: 40, height: 6)
                                            
                                        }
                                        .frame(width: 70, height: 70, alignment: .center)
                                        .background(Color(.systemGray5))
                                        .cornerRadius(20)
                                        Spacer()
                                    }
                                    Text("\(menuItems[index].quantity)")
                                        .font(.system(size: 60))
                                        .frame(width: 60, height: 60)
                                }
                                .frame(width: 400, height: 220)
                                .padding()
                                .background(Color(.systemGray6))
                            }
                        }
                    }
                    .frame(width: geometry.size.width * 0.6)
                }
                .frame(width: geometry.size.width * 0.6)
                VStack {
                    Text("カート")
                    List(menuItems.filter { $0.shoptype == shopInt}) { menuItem in
                        Text("\(menuItem.name) × \(menuItem.quantity)")
                    }
                    .background(Color(.systemGray5))
                    HStack {
                        VStack {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Button {
                                var allzero = true
                                for obj in menuItems {
                                    if obj.quantity != 0 {
                                        allzero = false
                                        break
                                    }
                                }
                                if allzero == false {
                                    menuResult = true
                                }
                            } label: {
                                Image(uiImage:UIImage(named: "PayOut")!)
                                    .resizable()
                                    .frame(width: 140, height: 140)
                        }
                            Spacer()
                        }
                    }
                    Spacer()
                    Spacer()
                }
                .frame(width: geometry.size.width * 0.4, height: geometry.size.height)
                .background(Color(.systemGray6))
            }
        }
    }
}

