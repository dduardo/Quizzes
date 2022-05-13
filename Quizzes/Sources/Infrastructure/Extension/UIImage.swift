//
//  UIImage.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 03/05/22.
//

import Foundation
import UIKit

extension UIImage {
    
    func convertImageToBase64String() -> String {
        return self.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
}
