//
//  OrderListView.swift
//  EasyEatsKitchenTableApplication
//
//  Created by NaYu on 2023/03/24.
//

import SwiftUI

struct TicketRowView: View {
    @State var togglecolor:Bool = false
    let ticket: Ticket
    let showStrings: [String: String]
    init(ticket: Ticket, showStrings: [String: String]) {
        self.ticket = ticket
        self.showStrings = showStrings
    }
    
    var body: some View {
        HStack {
            Text(ticket.id)
                .font(.title3)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            ForEach(ticket.values.sorted(by: <), id: \.key) { key, value in
                if let showString = showStrings[key] {
                    Text("\(showString): \(stringValue(value))    ")
                        .font(.title3)
                } else {
                    Text("\(key): \(stringValue(value))    ")
                        .font(.title3)
                }
            }
            Spacer()
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture{
            togglecolor.toggle()
        }
        .background{
            if togglecolor {
                Color.yellow
            } else {
                Color.white
            }
        }
    }
    private func stringValue(_ value: Any) -> String {
        if let value = value as? Int {
            return "\(value)"
        } else if let value = value as? String {
            return value
        } else {
            return ""
        }
    }
}

struct OrderListView: View {
    @ObservedObject var viewModel:FirebaseDatabaseService
        var body: some View {
            List(viewModel.tickets) { ticket in
                TicketRowView(ticket: ticket, showStrings: viewModel.getShowString(forRefString: viewModel.refString))
            }
        }
}
