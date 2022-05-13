//
//  UIColor.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 03/05/22.
//

import Foundation
import UIKit
// areia rgb(220,203,181)

extension UIColor {
    
    open class var venetianRed: UIColor {
        return UIColor(red: 204, green: 21, blue: 18)
    }
    
    open class var cultured: UIColor {
        return UIColor(red: 244, green: 244, blue: 244)
    }
    
    open class var areia: UIColor {
        return UIColor(red: 220, green: 203, blue: 181)
    }
    
    open class var davyGrey: UIColor {
        return UIColor(red: 92, green: 92, blue: 92)
    }
    
    open class var davyGreyLight: UIColor {
        return UIColor(red: 92, green: 92, blue: 92).withAlphaComponent(1)
    }

    convenience init(red: Int, green: Int, blue: Int, alphaValue: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alphaValue)
    }
}
