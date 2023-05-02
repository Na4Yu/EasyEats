//
//  FirebaseDatabaseHandler.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/04/21.
//

import Foundation
import Firebase

struct easyeatsOrder: Identifiable {
    let id = UUID()
    let c1:Int
    let c2:Int
    let g1:Int
    let s1:Int
    let t1:Int
    let y1:Int
}

struct easyeatsReturnOrder: Identifiable {
    let id = UUID()
    let c:Int
    let g:Int
    let s:Int
    let t:Int
    let y:Int
    let orderKey:String
}

func pushOrder(order:easyeatsOrder, completion: @escaping (String?) -> Void) {
    let queueRef = Database.database(url: "DBRef").reference(withPath: "ticketqueue").childByAutoId()
    let orderKey = queueRef.key
    guard let key = orderKey else {
        print("Error: Failed to generate order key")
        completion(nil)
        return
    }
    print(orderKey!)
    print(order)
    let data = [
        "c" : [
            "1" : order.c1,
            "2" : order.c2
        ],
        "flag" : false,
        "g" : [
            "1" : order.g1
        ],
        "s" : [
            "1" : order.s1,
            "2" : 0
        ],
        "t" : [
            "1" : order.t1
        ],
        "y" : [
            "1" : order.y1
        ]
    ] as [String : Any]
    queueRef.setValue(data) { (error, ref) in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            completion(nil)
        } else {
            completion(key)
        }
    }
}

func searchOrderkey(orderKey: String, in reference: DatabaseReference, currentTry:Int = 0, completion: @escaping (DataSnapshot?) -> Void) {
    let maxTries:Int = 10
    reference.observeSingleEvent(of: .value) { (snapshot) in
        if snapshot.hasChild(orderKey), let orderSnapshot = snapshot.childSnapshot(forPath: orderKey) as? DataSnapshot {
            completion(orderSnapshot)
        } else {
            if currentTry < maxTries {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    searchOrderkey(orderKey: orderKey, in: reference, currentTry: currentTry + 1, completion: completion)
                }
                } else {
                    completion(nil)
                }
            }
        }
    
}
