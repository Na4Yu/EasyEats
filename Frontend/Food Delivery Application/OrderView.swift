//
//  OrderView.swift
//  EasyEatsFoodstuffDeliveryApplication
//
//  Created by NaYu on 2023/03/15.
//

import SwiftUI
import Firebase

struct ListItem: View {
    @State private var isExpanded:Bool = false
    @State private var toggleServeable:Bool = false
    @State private var toggleServed:Bool = false
    @ObservedObject var viewModel: FirebaseDatabaseService
    let typeString: String
    let ticket: Ticket
    let showStrings: [String: String]
    init(typeString: String, ticket: Ticket, showStrings: [String: String], viewModel: FirebaseDatabaseService) {
        self.typeString = typeString
        self.ticket = ticket
        self.showStrings = showStrings
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
                HStack {
                        Text(ticket.id)
                            .font(.system(size: 25))
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        ForEach(ticket.ordervalues.sorted(by: <), id: \.key) { key, value in
                            if let showString = showStrings[key] {
                                Text("\(showString): \(stringValue(value))    ")
                                    .font(.system(size: 20))
                            } else {
                                Text("\(key): \(stringValue(value))    ")
                                    .font(.system(size: 20))
                            }
                        }
                        Spacer()
                }
                .contentShape(Rectangle())
                .padding()
                .onTapGesture{
                isExpanded.toggle()
                }
                .background{
                if toggleServeable == true {
                    Color(red: 85/255, green: 255/255, blue: 85/255)
                } else {
                    Color.white
                }
                }
            if isExpanded {
                HStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    Toggle(isOn: $toggleServeable) {
                        Text("受け取り可能")
                            .font(.system(size: 20))
                    }
                    .padding()
                    .onChange(of: toggleServeable) { newvalue in
                        isExpanded = false
                        if newvalue == true {
                            viewModel.updateBool(forrefString: typeString, ticketnum: Int(ticket.id) ?? 0, toggletype: "serveable", to: true)
                        } else {
                            viewModel.updateBool(forrefString: typeString, ticketnum: Int(ticket.id) ?? 0, toggletype: "serveable", to: false)
                        }
                    }
                    Spacer()
                    Toggle(isOn: $toggleServed) {
                        Text("受け取り済み")
                            .font(.system(size: 20))
                    }
                    .padding()
                    .onChange(of: toggleServed) { newvalue in
                        if newvalue == true {
                            isExpanded = false
                            viewModel.updateBool(forrefString: typeString, ticketnum: Int(ticket.id) ?? 0, toggletype: "served", to: true)
                        } else {
                            viewModel.updateBool(forrefString: typeString, ticketnum: Int(ticket.id) ?? 0, toggletype: "served", to: false)
                        }
                    }
                    Spacer()
                    Spacer()
                }
            }
        }
        .onAppear{
            if ticket.kitchenvalues["serveable"] == 0 {
                toggleServeable = false
            } else {
                toggleServeable = true
            }
            if ticket.servevalues["served"] == 0 {
                toggleServed = false
            } else {
                toggleServeable = true
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

struct OrderView: View {
    @State private var expandedList: Int?
    @ObservedObject var viewModel: FirebaseDatabaseService
    @Binding var typeString: String
    var body: some View {
        switch typeString{
        case "C":
            List {
                ForEach(viewModel.ticketC) { ticket in
                    ListItem(typeString: typeString, ticket: ticket, showStrings: viewModel.getShowString(forRefString: "C"), viewModel: viewModel)
                        .animation(Animation.easeInOut(duration: 0.4), value: 200)
                }
            }
        case "G":
            List {
                ForEach(viewModel.ticketG) { ticket in
                    ListItem(typeString: typeString,ticket: ticket, showStrings: viewModel.getShowString(forRefString: "G"), viewModel: viewModel)
                }
            }
        case "S":
            List {
                ForEach(viewModel.ticketS) { ticket in
                    ListItem(typeString: typeString,ticket: ticket, showStrings: viewModel.getShowString(forRefString: "S"), viewModel: viewModel)
                }
            }
        case "T":
            List {
                ForEach(viewModel.ticketT) { ticket in
                    ListItem(typeString: typeString,ticket: ticket, showStrings: viewModel.getShowString(forRefString: "T"), viewModel: viewModel)
                }
            }
        case "Y":
            List {
                ForEach(viewModel.ticketY) { ticket in
                    ListItem(typeString: typeString,ticket: ticket, showStrings: viewModel.getShowString(forRefString: "Y"), viewModel: viewModel)
                }
            }
        default:
            List {
                ForEach(viewModel.ticketC) { ticket in
                    ListItem(typeString: typeString,ticket: ticket, showStrings: viewModel.getShowString(forRefString: "C"), viewModel: viewModel)
                }
            }
        }
    }
}

