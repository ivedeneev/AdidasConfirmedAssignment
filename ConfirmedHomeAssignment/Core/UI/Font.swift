//
//  Font.swift
//  ConfirmedHomeAssignment
//
//  Created by Igor Vedeneev on 17.09.2021.
//

import SwiftUI
import UIKit.UIFont

extension Font {
    static var title = Font(UIFont.title)
    static var price = Font(UIFont.price)
    static var body = Font(UIFont.body)
    static var header = Font.body.bold()
}

extension UIFont {
    static var title = UIFont(name: "Avenir-Medium", size: 28)!
    static var price = UIFont(name: "Avenir", size: 28)!
    static var body = UIFont(name: "Avenir", size: 16)!
    
    static var listTitle = UIFont(name: "Avenir-Medium", size: 18)!
    static var listPrice = UIFont(name: "Avenir", size: 18)!
}
