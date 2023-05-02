//
//  TicketPDFHandler.swift
//  EasyEatsPOSApplication
//
//  Created by NaYu on 2023/04/20.
//

import Foundation
import UIKit
import PDFKit
import BRLMPrinterKit

final class CreatePDF: PDFPage {
    private let width = 620
    private let height = 290
    private var shopType = "C"
    private var num1 = 0
    private var num2 = 0
    private var keyString = ""
    private var ordernum = "0000"

    init(shopType:String, num1:Int, num2:Int, keyString:String, ordernum :Int) {
        self.shopType = shopType
        self.num1 = num1
        self.num2 = num2
        self.keyString = keyString
        self.ordernum = String(format: "%04d", ordernum)
        super.init()
    }

    override func draw(with box: PDFDisplayBox, to context: CGContext) {
        super.draw(with: box, to: context)
        UIGraphicsPushContext(context)
        context.translateBy(x: 0.0, y: CGFloat(height))
        context.scaleBy(x: 1.0, y: -1.0)
        let alignment =  NSMutableParagraphStyle()
        alignment.alignment = .center
        "＜EasyEats 食品整理券＞".draw(in: CGRect(x: 0, y: 0, width: width, height: height), withAttributes: [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans W6", size: 35) as Any, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: alignment])
        "\(shopType) \(ordernum)".draw(in: CGRect(x: 0, y: 45, width: width, height: height), withAttributes: [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans W6", size: 120) as Any, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: alignment])
        "注文識別キー:\(keyString)".draw(in: CGRect(x: 10, y: 260, width: width, height: height), withAttributes: [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans W6", size: 25) as Any, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: alignment])
        switch shopType {
        case "C":
            "食品名：\(num1)\n食品名：\(num2)".draw(in: CGRect(x: 0, y: 180, width: width, height: height), withAttributes: [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans", size: 30) as Any, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: alignment])
        case "G":
            "食品名：\(num1)".draw(in: CGRect(x: 0, y: 180, width: width, height: height), withAttributes: [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans", size: 30) as Any, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: alignment])
        case "S":
            "食品名：\(num1)".draw(in: CGRect(x: 0, y: 180, width: width, height: height), withAttributes: [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans", size: 30) as Any, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: alignment])
        case "T":
            "食品名：\(num1)".draw(in: CGRect(x: 0, y: 180, width: width, height: height), withAttributes: [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans", size: 30) as Any, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: alignment])
        case "Y":
            "食品名：\(num1)".draw(in: CGRect(x: 0, y: 180, width: width, height: height), withAttributes: [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans", size: 30) as Any, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: alignment])
        default:
            "印刷ミス\n印刷ミス".draw(in: CGRect(x: 0, y: 180, width: width, height: height), withAttributes: [NSAttributedString.Key.font: UIFont(name: "Hiragino Sans", size: 30) as Any, NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.paragraphStyle: alignment])
        }
    }

    override func bounds(for box: PDFDisplayBox) -> CGRect {
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
    
}

func TicketPDFHandler(orderkey:String, c1:Int, c2:Int, cnum:Int, g1:Int, gnum:Int, s1:Int, s2:Int, snum:Int, t1:Int, tnum:Int, y1:Int, ynum:Int, completion: @escaping (URL?) -> Void){
    let pdf = PDFDocument()
    if (y1 != 0) {
        pdf.insert(CreatePDF(shopType: "Y", num1: y1, num2: 0, keyString: orderkey, ordernum: ynum), at: 0)
    }
    if (t1 != 0) {
        pdf.insert(CreatePDF(shopType: "T", num1: t1, num2: 0, keyString: orderkey, ordernum: tnum), at: 0)
    }
    if (s1+s2 != 0) {
        pdf.insert(CreatePDF(shopType: "S", num1: s1, num2: s2, keyString: orderkey, ordernum: snum), at: 0)
    }
    if (g1 != 0) {
        pdf.insert(CreatePDF(shopType: "G", num1: g1, num2: 0, keyString: orderkey, ordernum: gnum), at: 0)
    }
    if (c1+c2 != 0) {
        pdf.insert(CreatePDF(shopType: "C", num1: c1, num2: c2, keyString: orderkey, ordernum: cnum), at: 0)
    }
    if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let path = url.appendingPathComponent("output.pdf")
        print(path)
        pdf.write(to: path)
        completion(path)
    }
    completion(nil)
}

func printPDF(path: URL, ip:String) -> String{
    let generateResult = BRLMPrinterDriverGenerator.open(BRLMChannel(wifiIPAddress: ip))
    guard generateResult.error.code == .noError,let printerDriver = generateResult.driver else {
        return "Error- Open Channel: \(generateResult.error.code)"
    }
    defer {
        printerDriver.closeChannel()
        print("Channel Closed")
    }
    guard let printSettings = BRLMQLPrintSettings(defaultPrintSettingsWith: .QL_810W)
    else {
        return "Error- Image file not found"
    }
    printSettings.labelSize = .dieCutW62H29
    printSettings.autoCut = false
    printSettings.cutAtEnd = true
    printSettings.hAlignment = .center
    printSettings.vAlignment = .center
    printSettings.scaleMode = .fitPageAspect
    let printError = printerDriver.printPDF(with: path, settings: printSettings)
    if printError.code != .noError {
        return "Error - Print Image: \(printError.code == .filepathURLError)"
    } else {
        return "Success"
    }
}
