//
//  Extensions.swift
//  Doista
//
//  Created by Andras Pal on 25/06/2020.
//  Copyright © 2020 Andras Pal. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Extensions

//Converting UIColor values to hex and back
//
//Usage:
//let green = UIColor(hex: "12FF10")
//let greenWithAlpha = UIColor(hex: "12FF10AC")
//UIColor.blue.toHex
//UIColor.orange.toHex()

extension UIColor {
    
    // MARK: - Initialization
    convenience init?(hex: String){
        
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {return nil}
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - Computed Properties
    var toHex: String? {
        return rgbaColoursToHex()
    }
    
    // MARK: - From UIColor to String
    func rgbaColoursToHex(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}

extension UIColor {

    static var randomRGBA: UIColor {
        return UIColor(red: .random(in: 0...0.5),
                       green: .random(in: 0...0.5),
                       blue: .random(in: 0...0.5),
                       alpha: 1.0)
    }
}

//Mixing the two extensions:
//
//let myColor: UIColor = .randomRGBA
//let myColorHex = myColor.rgbaColoursToHex()
//print(myColorHex!)
//let myColorFromHex = UIColor(hex: myColorHex!)

//extension UIColor {
//
//    var rgbaColour: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
//        var red: CGFloat = 0
//        var green: CGFloat = 0
//        var blue: CGFloat = 0
//        var alpha: CGFloat = 0
//        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
//
//        return (red, green, blue, alpha)
//    }
//}

//extension String {
//
//    func slice(from: String, to: String) -> String? {
//
//        return (range(of: from)?.upperBound).flatMap { substringFrom in
//            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
//                String(self[substringFrom..<substringTo])
//            }
//        }
//    }
//}

extension String {
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

extension UIViewController {
    
    func createAlert(alert: UIAlertController, action: UIAlertAction) {
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: String.getString(.cancel), style: .cancel, handler: nil))
        alert.preferredAction = action
        present(alert, animated: true, completion: nil)
    }
}
