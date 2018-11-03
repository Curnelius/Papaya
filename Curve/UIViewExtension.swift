//
//  UIViewExtension.swift
//  Papaya
//
//  Created by ran T on 03/11/2018.
//  Copyright © 2018 ran T. All rights reserved.
//

import Foundation
import UIKit



    
    extension UIView {
        
        func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
            layer.masksToBounds = false
            layer.shadowOffset = offset
            layer.shadowColor = color.cgColor
            layer.shadowRadius = radius
            layer.shadowOpacity = opacity
            
            let backgroundCGColor = backgroundColor?.cgColor
            backgroundColor = nil
            layer.backgroundColor =  backgroundCGColor
        }
    }
 
