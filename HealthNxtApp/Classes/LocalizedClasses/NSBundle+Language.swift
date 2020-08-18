//  Converted with Swiftify v1.0.6402 - https://objectivec2swift.com/
//
//  NSBundle+Language.swift
//  CitizenApp
//
//  Created by Harshini Nerella on 21/07/17.
//  Copyright © 2017 Ascendia. All rights reserved.
//

import Foundation

extension Bundle {
    
    class func setLanguage(_ language: String) {
        
        if UserDefaults.standard.object(forKey: "isCustomBundleClassSet") == nil {
           
            object_setClass(Bundle.main, CustomBundle.self)
            UserDefaults.standard.set("yes", forKey: "isCustomBundleClassSet")
            UserDefaults.standard.synchronize()

        }
            /* TODO: move below code to a static variable initializer (dispatch_once is deprecated) */
        let value: Any? = language.count>0 ? Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj")!) : Bundle(path: Bundle.main.path(forResource: "Base", ofType: "lproj")!)
        objc_setAssociatedObject(Bundle.main, &kBundleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
