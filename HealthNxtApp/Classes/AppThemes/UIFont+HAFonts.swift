//
//  UIFont+HAFonts.swift
//  ha
//
//  Created by Satyanand T on 17/10/17.
//  Copyright © 2017 KaaraInfoSystems. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func haBoldFont(fontSize:CGFloat) -> UIFont {
        let font : UIFont = UIFont.init(name: "Nexa Bold", size: fontSize)!
        return font
    }
    class func haFont(fontSize:CGFloat) -> UIFont {
        let font : UIFont = UIFont.init(name: "Nexa Regular", size: fontSize)!
        return font
    }

    
    
    
}

