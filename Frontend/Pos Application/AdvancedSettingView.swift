//
//  AdvancedSettingView.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/04/24.
//

import SwiftUI

struct AdvancedSettingView: View {
    @Binding var shopString:String
    @Binding var settingIp:String
    @Binding var shopInt:Int
    @State var shopselections = ["店舗名"]
    @State var settingIPs =
    ["//IpArray"]
    var body: some View {
        VStack {
            Spacer()
            Text("店舗選択")
                .font(.system(size: 40))
            Picker(selection: $shopString, label:Text("店舗選択"), content: {
                ForEach(shopselections, id:\.self) {
                    value in
                    Text("\(value)")
                        .tag(value)
                        .font(.system(size: 40))
                        .frame(width: 40, height: 40)
                        .background(Color(.systemGray5))
                }
            })
            .onChange(of: shopString) { newvalue in
                switch newvalue {
                case "食券システム":
                    shopInt = 0
                case "クレープ":
                    shopInt = 1
                case "焼き鳥":
                    shopInt = 2
                case "フランクフルト":
                    shopInt = 3
                case "たこ焼き":
                    shopInt = 4
                case "塩焼きそば":
                    shopInt = 5
                case "綿飴":
                    shopInt = 6
                case "クロッフル":
                    shopInt = 7
                case "駅弁":
                    shopInt = 8
                case "紳士喫茶":
                    shopInt = 9
                case "音楽喫茶":
                    shopInt = 10
                case "宇宙食":
                    shopInt = 11
                case "ドリンク":
                    shopInt = 12
                default:
                    shopInt = 0
                    
                }
            }
            Spacer()
            Text("プリンターIP設定")
                .font(.system(size: 40))
            Picker(selection: $settingIp, label:Text("IP"), content: {
                ForEach(settingIPs, id:\.self) {
                    value in
                    Text("\(value)")
                        .tag(value)
                        .font(.system(size: 40))
                        .frame(width: 40, height: 40)
                }
            })
            Spacer()
        }
    }
}

struct AdvancedSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedSettingView(shopString: .constant("食券システム"), settingIp: .constant("Ip"), shopInt: .constant(0))
    }
}
