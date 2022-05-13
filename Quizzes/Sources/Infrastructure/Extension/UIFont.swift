//
//  UIFont.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 03/05/22.
//

import Foundation
import UIKit

extension UIFont {
    
    // MARK: - Private Methods

    private class func appDefaultFont(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    private class func appDefaultBold(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    private static func appBoldFont(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: CaviarFont.appBold.rawValue, size: size) else {
            return appDefaultBold(size)
        }
        return font
    }
    
    private static func appRegularFont(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: CaviarFont.appRegular.rawValue, size: size) else {
            return appDefaultFont(size)
        }
        return font
    }
    
    private static func appItalicBoldFont(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: CaviarFont.appItalicBold.rawValue, size: size) else {
            return appDefaultFont(size)
        }
        return font
    }
    
    private static func appItalicRegularFont(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: CaviarFont.appItalicRegular.rawValue, size: size) else {
            return appDefaultFont(size)
        }
        return font
    }
    
    
    // MARK: - Public Methods
    
    static func appBoldFont(ofSize size: FontSize) -> UIFont {
        return appBoldFont(ofSize: size.rawValue)
    }
    
    static func appRegularFont(ofSize size: FontSize) -> UIFont {
        return appRegularFont(ofSize: size.rawValue)
    }
    
    static func appItalicBoldFont(ofSize size: FontSize) -> UIFont {
        return appItalicBoldFont(ofSize: size.rawValue)
    }
    
    static func appItalicRegularFont(ofSize size: FontSize) -> UIFont {
        return appItalicRegularFont(ofSize: size.rawValue)
    }
}

// MARK: - Enums

enum CaviarFont: String {
    case appBold = "CaviarDreams-Bold"
    case appRegular = "CaviarDreams"
    case appItalicBold = "CaviarDreams-BoldItalic"
    case appItalicRegular = "CaviarDreams-Italic"
}

enum FontSize: CGFloat {
    case small = 12.0
    case normal = 14.0
    case subTitle = 16.0
    case title = 24.0
    case superTitle = 32.0
}
