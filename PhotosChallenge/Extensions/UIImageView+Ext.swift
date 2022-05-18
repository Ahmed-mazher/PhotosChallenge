//
//  UIImageView+Ext.swift
//  PhotosChallenge
//
//  Created by Front Tech on 18/05/2022.
//

import Foundation
import UIKit
import Kingfisher


extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
