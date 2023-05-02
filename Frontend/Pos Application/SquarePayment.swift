//
//  SquarePayment.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/04/28.
//

import Foundation
import SquarePointOfSaleSDK

enum PaymentMethod {
    case cash
    case card
}

func payBySquare(price:Int,store:String,method:PaymentMethod,completion: @escaping (Bool?) -> Void){
    SCCAPIRequest.setApplicationID(applicationID)
    do {
        let money = try SCCMoney(amountCents: price, currencyCode: "JPY")
        
        let apiRequest =
        try SCCAPIRequest(
            callbackURL: callbackURL,
            amount: money,
            userInfoString: nil,
            locationID: locationID,
            notes: "\(store)",
            customerID: nil,
            supportedTenderTypes: (method == .card ? .card :.cash),
            clearsDefaultFees: false,
            returnsAutomaticallyAfterPayment: true,
            disablesKeyedInCardEntry: true,
            skipsReceipt: true)
        try SCCAPIConnection.perform(apiRequest)
        completion(true)
    } catch let error as NSError {
        print(error.localizedDescription)
        completion(false)
    }
}
