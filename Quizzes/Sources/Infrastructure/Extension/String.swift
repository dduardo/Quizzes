//
//  String.swift
//  Quizzes
//
//  Created by Carlos Eduardo Santiago on 03/05/22.
//

import Foundation
import UIKit

extension String {

    private static let escapedChars = [
        (#"\0"#, "\0"),
        (#"\t"#, "\t"),
        (#"\n"#, "\n"),
        (#"\r"#, "\r"),
        (#"\""#, "\""),
        (#"\'"#, "\'"),
        (#"\\"#, "\\"),
        ("\"", ""),
        (",", "")
    ]
    var unescaped: String {
        var result: String = self
        String.escapedChars.forEach {
            result = result.replacingOccurrences(of: $0.0, with: $0.1)
        }
        return result
    }
    
    func convertBase64StringToImage() -> UIImage {
        if let imageData = Data(base64Encoded: self),
           let image = UIImage(data: imageData) {
           return image
        }

        return UIImage()
    }
}
