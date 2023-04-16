//
//  FirebaseDatabaseHandler.swift
//  EasyEatsFoodstuffDeliveryApplication
//
//  Created by NaYu on 2023/04/07.
//

import Foundation
import Firebase

extension Dictionary {
    func excluding(keys: [Key]) -> Dictionary {
        var result = self
        for key in keys {
            result[key] = nil
        }
        return result
    }
}
struct Ticket: Identifiable {
    let id: String
    let ordervalues: [String: Int]
    let kitchenvalues: [String: Int]
    let servevalues: [String: Int]
}

class FirebaseDatabaseService: ObservableObject {
    @Published var ticketC = [Ticket]()
    @Published var ticketG = [Ticket]()
    @Published var ticketS = [Ticket]()
    @Published var ticketT = [Ticket]()
    @Published var ticketY = [Ticket]()
    private var refHandleC: DatabaseHandle?
    private var refHandleG: DatabaseHandle?
    private var refHandleS: DatabaseHandle?
    private var refHandleT: DatabaseHandle?
    private var refHandleY: DatabaseHandle?
    private var customShowStrings: [String: [String: String]] = [
        "C": [
            "1":"チョコ",
            "2":"苺"
        ],
        "G": [
            "1":"焼き鳥４本セット"
        ],
        "S": [
            "1":"プレーン",
            "2":"ペッパー"
        ],
        "T": [
            "1":"たこ焼き"
        ],
        "Y": [
            "1":"塩焼きそば"
        ]]
    
    init() {
        observeTickets()
    }
    
    func observeTickets() {
        let refc = Database.database().reference(withPath: "tickets/C/serve")
        refHandleC = refc.observe(.value) { snapshot in
            var tickets = [Ticket]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let values = childSnapshot.value as? [String: Int] {
                    let ticket = Ticket(id: childSnapshot.key, ordervalues: values.excluding(keys: ["serveable", "served"]), kitchenvalues: values.excluding(keys: ["1", "2", "served"]), servevalues: values.excluding(keys: ["1", "2", "serveable"]))
                    tickets.append(ticket)
                }
            }
            self.ticketC = tickets
        }
        let refg = Database.database().reference(withPath: "tickets/G/serve")
        refHandleG = refg.observe(.value) { snapshot in
            var tickets = [Ticket]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let values = childSnapshot.value as? [String: Int] {
                    let ticket = Ticket(id: childSnapshot.key, ordervalues: values.excluding(keys: ["serveable", "served"]), kitchenvalues: values.excluding(keys: ["1", "2", "served"]), servevalues: values.excluding(keys: ["1", "2", "serveable"]))
                    tickets.append(ticket)
                }
            }
            self.ticketG = tickets
        }
        let refs = Database.database().reference(withPath: "tickets/S/serve")
        refHandleS = refs.observe(.value) { snapshot in
            var tickets = [Ticket]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let values = childSnapshot.value as? [String: Int] {
                    let ticket = Ticket(id: childSnapshot.key, ordervalues: values.excluding(keys: ["serveable", "served"]), kitchenvalues: values.excluding(keys: ["1", "2", "served"]), servevalues: values.excluding(keys: ["1", "2", "serveable"]))
                    tickets.append(ticket)
                }
            }
            self.ticketS = tickets
        }
        let reft = Database.database().reference(withPath: "tickets/T/serve")
        refHandleT = reft.observe(.value) { snapshot in
            var tickets = [Ticket]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let values = childSnapshot.value as? [String: Int] {
                    let ticket = Ticket(id: childSnapshot.key, ordervalues: values.excluding(keys: ["serveable", "served"]), kitchenvalues: values.excluding(keys: ["1", "2", "served"]), servevalues: values.excluding(keys: ["1", "2", "serveable"]))
                    tickets.append(ticket)
                }
            }
            self.ticketT = tickets
        }
        let refy = Database.database().reference(withPath: "tickets/Y/serve")
        refHandleY = refy.observe(.value) { snapshot in
            var tickets = [Ticket]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let values = childSnapshot.value as? [String: Int] {
                    let ticket = Ticket(id: childSnapshot.key, ordervalues: values.excluding(keys: ["serveable", "served"]), kitchenvalues: values.excluding(keys: ["1", "2", "served"]), servevalues: values.excluding(keys: ["1", "2", "serveable"]))
                    tickets.append(ticket)
                }
            }
            self.ticketY = tickets
        }
    }
    
    func getShowString(forRefString refString: String) -> [String: String] {
        return customShowStrings[refString] ?? [:]
    }
    
    func updateBool(forrefString refString: String, ticketnum num: Int, toggletype togglestring: String, to tovalue: Bool) {
        let ref = "tickets/\(refString)/main/\(num)/\(togglestring)"
        Database.database().reference(withPath: ref).setValue(tovalue)
        observeTickets()
    }
    
    func removeObservers() {
        let refc = Database.database().reference(withPath: "tickets/C/serve")
        let refg = Database.database().reference(withPath: "tickets/G/serve")
        let refs = Database.database().reference(withPath: "tickets/S/serve")
        let reft = Database.database().reference(withPath: "tickets/T/serve")
        let refy = Database.database().reference(withPath: "tickets/Y/serve")
        refc.removeAllObservers()
        refg.removeAllObservers()
        refs.removeAllObservers()
        reft.removeAllObservers()
        refy.removeAllObservers()
    }
}
