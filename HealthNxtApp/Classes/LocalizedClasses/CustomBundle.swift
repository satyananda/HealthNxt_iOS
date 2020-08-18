//  Converted with Swiftify v1.0.6402 - https://objectivec2swift.com/
//
//  BundleExample.swift
//  CitizenApp
//
//  Created by Harshini Nerella on 21/07/17.
//  Copyright © 2017 Ascendia. All rights reserved.
//

import Foundation
import ObjectiveC

var kBundleKey = 0

class CustomBundle: Bundle {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle: Bundle? = objc_getAssociatedObject(self, &kBundleKey) as? Bundle
        if bundle != nil {
            return (bundle?.localizedString(forKey: key, value: value ?? "", table: tableName ?? ""))!
        } else {
            return super.localizedString(forKey: key, value: value ?? "", table: tableName ?? "")
        }
    }
}
