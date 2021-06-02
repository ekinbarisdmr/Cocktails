//
//  ImageExtention.swift
//  Cocktail
//
//  Created by Ekin Barış Demir on 31.05.2021.
//

import Foundation
import UIKit

extension UIImage {
    var data: Data? {
        if let data = self.jpegData(compressionQuality: 0.2) {
            return data
        } else {
            return nil
        }
    }
}

extension Data {
    var image: UIImage? {
        if let image = UIImage(data: self) {
            return image
        } else {
            return nil
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

