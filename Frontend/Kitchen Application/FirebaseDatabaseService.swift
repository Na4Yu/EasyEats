//
//  FirebaseDatabaseService.swift
//  EasyEatsKitchenTableApplication
//
//  Created by NaYu on 2023/03/26.
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
    let values: [String: Int]
    
}

struct ToggleVal: Identifiable {
    let id: String
    var values: Int
}

class FirebaseDatabaseService: ObservableObject {
    @Published var tickets = [Ticket]()
    @Published var toggles = [ToggleVal]()
    @Published var refString = "tickets/C/orders"
    @Published var refToggle = "foodstock/c"
    @Published var adminUser: Bool = false
    @Published var shopName = "クレープ"
    private var loginUser:String = ""
    private var refHandle: DatabaseHandle?
    private var refToggleHandle: DatabaseHandle?
    private var customShowStrings: [String: [String: String]] = [
        "tickets/C/orders": [
            "1":"チョコ",
            "2":"苺"
        ],
        "tickets/G/orders": [
            "1":"焼き鳥４本セット"
        ],
        "tickets/S/orders": [
            "1":"プレーン",
            "2":"ペッパー"
        ],
        "tickets/T/orders": [
            "1":"たこ焼き"
        ],
        "tickets/Y/orders": [
            "1":"塩焼きそば"
        ]]
    
    init() {
        observeTickets()
        observeToggle()
    }
    
    private func observeTickets() {
        let ref = Database.database().reference(withPath: refString)
        refHandle = ref.observe(.value) { snapshot in
            var tickets = [Ticket]()
            for child in snapshot.children {
                if let childSnaphot = child as? DataSnapshot,
                   let values = childSnaphot.value as? [String: Int] {
                    let ticket = Ticket(id: childSnaphot.key, values: values.excluding(keys: ["serveable", "served"]))
                    tickets.append(ticket)
                }
            }
            self.tickets = tickets
        }
    }
    
    private func observeToggle() {
        let ref = Database.database(url: "Stock Database Reference").reference(withPath: refToggle)
        refToggleHandle = ref.observe(.value) { snapshot in
            var toggles = [ToggleVal]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    let toggleswitch: Int = childSnapshot.value as! Int
                    let toggle = ToggleVal(id: String(childSnapshot.key), values: toggleswitch)
                    toggles.append(toggle)
                }
            }
            self.toggles = toggles
        }
    }
    
    func usercheck() {
        if let user = Auth.auth().currentUser {
            loginUser = user.email ?? ""
        }
        if loginUser == "Account Mail Address" {
            refString = "tickets/C/orders"
            shopName = "クレープ"
        } else if loginUser == "Account Mail Address" {
            refString = "tickets/G/orders"
            shopName = "焼き鳥"
        } else if loginUser == "Account Mail Address" {
            refString = "tickets/S/orders"
            shopName = "フランクフルト"
        } else if loginUser == "Account Mail Address" {
            refString = "tickets/T/orders"
            shopName = "たこ焼き"
        } else if loginUser == "Account Mail Address" {
            refString = "tickets/Y/orders"
            shopName = "塩焼きそば"
        } else if loginUser == "" {
        } else {
            adminUser = true
        }
        changeRef(to: refString)
        observeToggle()
    }
    
    func changeRef(to newRef: String) {
        if let refHandle = refHandle {
            let ref = Database.database().reference(withPath: refString)
            ref.removeObserver(withHandle: refHandle)
        }
        if let refToggleHandle = refToggleHandle {
            let ref = Database.database(url: "Stock Database Reference").reference(withPath:refToggle)
            ref.removeObserver(withHandle: refToggleHandle)
        }
        refString = newRef
        observeTickets()
        switch newRef {
        case "tickets/C/orders":
            refToggle = "foodstock/c"
        case "tickets/G/orders":
            refToggle = "foodstock/g"
        case "tickets/S/orders":
            refToggle = "foodstock/s"
        case "tickets/T/orders":
            refToggle = "foodstock/t"
        case "tickets/Y/orders":
            refToggle = "foodstock/y"
        default:
            refToggle = "foodstock/c"
        }
        observeToggle()
        
    }

    func getShowString(forRefString refString: String) -> [String: String] {
        return customShowStrings[refString] ?? [:]
    }
    
    func updateToggle(on num: Int, to toggleval: Int) {
        let ref = "\(refToggle)/\(num)"
        Database.database(url: "Stock Database Reference").reference(withPath: ref).setValue(toggleval)
        observeToggle()
    }
    
    func logoutRef() {
        let ref = Database.database().reference(withPath: refString)
        let refT = Database.database(url: "Stock Database Reference").reference(withPath:refToggle)
        ref.removeAllObservers()
        refT.removeAllObservers()
        toggles = [ToggleVal]()
    }
}
