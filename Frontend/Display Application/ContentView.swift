//
//  ContentView.swift
//  EasyEatsOrderDisplayApplication
//
//  Created by NaYu on 2023/04/09.
//

import SwiftUI

extension Array {
    
}

struct ContentView: View {
    @ObservedObject var viewModel = FirebaseDatabaseService()
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack (spacing: 0){
                    HStack {
                        Spacer()
                        Text("**EasyEats 番号掲示板**")
                            .font(.system(size: 55))
                            .foregroundColor(Color(.black))
                        Spacer()
                    }
                    .frame(height: geometry.size.height * 0.09)
                    .background(Color(red: 242/255, green: 242/255, blue: 242/255))
                    HStack {
                        VStack {
                            Spacer()
                                .frame(height: geometry.size.height * 0.01)
                            Text("**クレープ**")
                                .foregroundColor(Color.black)
                                .font(.system(size: 55))
                            Spacer()
                            VStack {
                                Text("**\(viewModel.displayC[4])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayC[4] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayC[3])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayC[3] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayC[2])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayC[2] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayC[1])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayC[1] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayC[0])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayC[0] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                            }
                            .frame(height: geometry.size.height * 0.6)
                            Spacer()
                        }
                        .frame(width: geometry.size.width * 0.185, height: geometry.size.height * 0.85)
                        .background(Color(.white))
                        Spacer()
                        VStack {
                            Spacer()
                                .frame(height: geometry.size.height * 0.01)
                            Text("**焼き鳥**")
                                .foregroundColor(Color.black)
                                .font(.system(size: 55))
                            Spacer()
                            VStack {
                                Text("**\(viewModel.displayG[4])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayG[4] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayG[3])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayG[3] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayG[2])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayG[2] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayG[1])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayG[1] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayG[0])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayG[0] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                            }
                            .frame(height: geometry.size.height * 0.6)
                            Spacer()
                        }
                        .frame(width: geometry.size.width * 0.185, height: geometry.size.height * 0.85)
                        .background(Color(.white))
                        Spacer()
                        VStack {
                            Spacer()
                                .frame(height: geometry.size.height * 0.01)
                            Text("**フランク**")
                                .foregroundColor(Color.black)
                                .font(.system(size: 55))
                            Spacer()
                            VStack {
                                Text("**\(viewModel.displayS[4])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayS[4] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayS[3])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayS[3] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayS[2])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayS[2] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayS[1])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayS[1] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayS[0])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayS[0] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                            }
                            .frame(height: geometry.size.height * 0.6)
                            Spacer()
                        }
                        .frame(width: geometry.size.width * 0.185, height: geometry.size.height * 0.85)
                        .background(Color(.white))
                        Spacer()
                        VStack {
                            Spacer()
                                .frame(height: geometry.size.height * 0.01)
                            Text("**たこ焼き**")
                                .foregroundColor(Color.black)
                                .font(.system(size: 55))
                            Spacer()
                            VStack {
                                Text("**\(viewModel.displayT[4])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayT[4] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayT[3])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayT[3] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayT[2])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayT[2] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayT[1])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayT[1] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayT[0])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayT[0] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                            }
                            .frame(height: geometry.size.height * 0.6)
                            Spacer()
                        }
                        .frame(width: geometry.size.width * 0.185, height: geometry.size.height * 0.85)
                        .background(Color(.white))
                        Spacer()
                        VStack {
                            Spacer()
                                .frame(height: geometry.size.height * 0.01)
                            Text("**塩焼きそば**")
                                .foregroundColor(Color.black)
                                .font(.system(size: 55))
                            Spacer()
                            VStack {
                                Text("**\(viewModel.displayY[4])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayY[4] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayY[3])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayY[3] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayY[2])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayY[2] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayY[1])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayY[1] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                                Spacer()
                                Text("**\(viewModel.displayY[0])**")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 50))
                                    .frame(width: geometry.size.width * 0.12, height: geometry.size.height * 0.1)
                                    .background{
                                        if viewModel.displayY[0] == "" {
                                            Color(.white)
                                        } else {
                                            Color(red: 230/255, green: 230/255, blue: 230/255)
                                        }
                                    }
                            }
                            .frame(height: geometry.size.height * 0.6)
                            Spacer()
                        }
                        .frame(width: geometry.size.width * 0.185, height: geometry.size.height * 0.85)
                        .background(Color(.white))
                    }
                    .background(Color(red: 247/255, green: 171/255, blue: 0))
                    .frame(height: geometry.size.height * 0.85)
                    VStack {
                        Spacer()
                        Text("**上に表示された番号とそれより小さい番号は受け取りが可能です**")
                            .font(.system(size: 50))
                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.06)
                    .background(Color(red: 82/255, green: 82/255, blue: 82/252))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
