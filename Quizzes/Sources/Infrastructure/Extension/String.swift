//
//  String.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 03/05/22.
//

import Foundation
import UIKit

extension String {

    func convertBase64StringToImage() -> UIImage {
        if let imageData = Data(base64Encoded: self),
           let image = UIImage(data: imageData) {
           return image
        }

        return UIImage()
    }
}
