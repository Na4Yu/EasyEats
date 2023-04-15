//
//  TradeConsoleView.swift
//  EasyEatsKitchenTableApplication
//
//  Created by NaYu on 2023/03/28.
//

import SwiftUI

struct ToggleView: View {
    @State private var toggleBool:Bool = false
    var toggleval: ToggleVal
    let showStrings: [String: String]
    @ObservedObject var viewModel:FirebaseDatabaseService
    init(toggleval: ToggleVal, showStrings: [String: String], viewModel: FirebaseDatabaseService) {
        self.toggleval = toggleval
        self.showStrings = showStrings
        self.viewModel = viewModel
    }
    var body: some View {
        HStack {
            Toggle(isOn: $toggleBool) {
                // Issue
                Text(showStrings[toggleval.id] ?? String(toggleval.id))
                    .font(.system(size: 15))
            }
            .padding()
            .onChange(of: toggleBool) { newvalue in
                if newvalue == true {
                    viewModel.updateToggle(on: Int(toggleval.id) ?? 0, to: 1)
                } else {
                    viewModel.updateToggle(on: Int(toggleval.id) ?? 0, to: 0)
                }
            }
        }
        .onAppear{
            if toggleval.values == 0 {
                toggleBool = false
            } else {
                toggleBool = true
            }
        }
    }
}

struct TradeConsoleView: View {
    @ObservedObject var viewModel:FirebaseDatabaseService
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Text("在庫状況")
                .font(.system(size: 30))
            List(viewModel.toggles) { toggleval in
                ToggleView(toggleval: toggleval, showStrings: viewModel.getShowString(forRefString: viewModel.refString), viewModel: viewModel)
            }
            .frame(maxHeight: 280)
            Spacer()
                .frame(maxHeight: 80)
        }
        
    }
}

struct TradeConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        TradeConsoleView(viewModel: FirebaseDatabaseService())
            .previewDevice("iPad (8th generation)")
    }
}
