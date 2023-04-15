//
//  FirebaseDatabaseService.swift
//  EasyEatsOrderDisplayApplication
//
//  Created by NaYu on 2023/04/11.
//

import Foundation
import Firebase

class FirebaseDatabaseService: ObservableObject {
    @Published var displayC = ["読み込み中","読み込み中","読み込み中","読み込み中","読み込み中"]
    @Published var displayG = ["読み込み中","読み込み中","読み込み中","読み込み中","読み込み中"]
    @Published var displayS = ["読み込み中","読み込み中","読み込み中","読み込み中","読み込み中"]
    @Published var displayT = ["読み込み中","読み込み中","読み込み中","読み込み中","読み込み中"]
    @Published var displayY = ["読み込み中","読み込み中","読み込み中","読み込み中","読み込み中"]
    private var orderHandleC: DatabaseHandle?
    private var orderHandleG: DatabaseHandle?
    private var orderHandleS: DatabaseHandle?
    private var orderHandleT: DatabaseHandle?
    private var orderHandleY: DatabaseHandle?

    init() {
        observeOrders()
    }

    private func observeOrders() {
        let refc = Database.database().reference(withPath: "tickets/C/display")
        orderHandleC = refc.observe(.value) { snapshot in
            var orders = [String]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    let order = String(childSnapshot.key)
                    orders.append(order)
                }
            }
            if orders.count >= 1 {
                self.displayC[0] = "C \(orders[orders.count - 1])"
            } else {
                self.displayC[0] = ""
            }
            if orders.count >= 2 {
                self.displayC[1] = "C \(orders[orders.count - 2])"
            } else {
                self.displayC[1] = ""
            }
            if orders.count >= 3 {
                self.displayC[2] = "C \(orders[orders.count - 3])"
            } else {
                self.displayC[2] = ""
            }
            if orders.count >= 4 {
                self.displayC[3] = "C \(orders[orders.count - 4])"
            } else {
                self.displayC[3] = ""
            }
            if orders.count >= 5 {
                self.displayC[4] = "C \(orders[orders.count - 5])"
            } else {
                self.displayC[4] = ""
            }
        }
        let refg = Database.database().reference(withPath: "tickets/G/display")
        orderHandleG = refg.observe(.value) { snapshot in
            var orders = [String]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    let order = String(childSnapshot.key)
                    orders.append(order)
                }
            }
            if orders.count >= 1 {
                self.displayG[0] = "G \(orders[orders.count - 1])"
            } else {
                self.displayG[0] = ""
            }
            if orders.count >= 2 {
                self.displayG[1] = "G \(orders[orders.count - 2])"
            } else {
                self.displayG[1] = ""
            }
            if orders.count >= 3 {
                self.displayG[2] = "G \(orders[orders.count - 3])"
            } else {
                self.displayG[2] = ""
            }
            if orders.count >= 4 {
                self.displayG[3] = "G \(orders[orders.count - 4])"
            } else {
                self.displayG[3] = ""
            }
            if orders.count >= 5 {
                self.displayG[4] = "G \(orders[orders.count - 5])"
            } else {
                self.displayG[4] = ""
            }
        }
        let refs = Database.database().reference(withPath: "tickets/S/display")
        orderHandleS = refs.observe(.value) { snapshot in
            var orders = [String]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    let order = String(childSnapshot.key)
                    orders.append(order)
                }
            }
            if orders.count >= 1 {
                self.displayS[0] = "S \(orders[orders.count - 1])"
            } else {
                self.displayS[0] = ""
            }
            if orders.count >= 2 {
                self.displayS[1] = "S \(orders[orders.count - 2])"
            } else {
                self.displayS[1] = ""
            }
            if orders.count >= 3 {
                self.displayS[2] = "S \(orders[orders.count - 3])"
            } else {
                self.displayS[2] = ""
            }
            if orders.count >= 4 {
                self.displayS[3] = "S \(orders[orders.count - 4])"
            } else {
                self.displayS[3] = ""
            }
            if orders.count >= 5 {
                self.displayS[4] = "S \(orders[orders.count - 5])"
            } else {
                self.displayS[4] = ""
            }
        }
        let reft = Database.database().reference(withPath: "tickets/T/display")
        orderHandleT = reft.observe(.value) { snapshot in
            var orders = [String]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    let order = String(childSnapshot.key)
                    orders.append(order)
                }
            }
            if orders.count >= 1 {
                self.displayT[0] = "T \(orders[orders.count - 1])"
            } else {
                self.displayT[0] = ""
            }
            if orders.count >= 2 {
                self.displayT[1] = "T \(orders[orders.count - 2])"
            } else {
                self.displayT[1] = ""
            }
            if orders.count >= 3 {
                self.displayT[2] = "T \(orders[orders.count - 3])"
            } else {
                self.displayT[2] = ""
            }
            if orders.count >= 4 {
                self.displayT[3] = "T \(orders[orders.count - 4])"
            } else {
                self.displayT[3] = ""
            }
            if orders.count >= 5 {
                self.displayT[4] = "T \(orders[orders.count - 5])"
            } else {
                self.displayT[4] = ""
            }
        }
        let refy = Database.database().reference(withPath: "tickets/Y/display")
        orderHandleY = refy.observe(.value) { snapshot in
            var orders = [String]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    let order = String(childSnapshot.key)
                    orders.append(order)
                }
            }
            if orders.count >= 1 {
                self.displayY[0] = "Y \(orders[orders.count - 1])"
            } else {
                self.displayY[0] = ""
            }
            if orders.count >= 2 {
                self.displayY[1] = "Y \(orders[orders.count - 2])"
            } else {
                self.displayY[1] = ""
            }
            if orders.count >= 3 {
                self.displayY[2] = "Y \(orders[orders.count - 3])"
            } else {
                self.displayY[2] = ""
            }
            if orders.count >= 4 {
                self.displayY[3] = "Y \(orders[orders.count - 4])"
            } else {
                self.displayY[3] = ""
            }
            if orders.count >= 5 {
                self.displayY[4] = "Y \(orders[orders.count - 5])"
            } else {
                self.displayY[4] = ""
            }
        }
    }
}
