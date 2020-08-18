//
//  HAConstants.swift
//  HealthAdvisor
//
//  Created by Satyanand T on 17/10/17.
//  Copyright © 2017 . All rights reserved.
//

import Foundation
import UIKit

public struct HAConstants {
    
    static let HA_APPLICATION_SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let HA_APPLICATION_SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let deviceVersion:Double = (UIDevice.current.systemVersion as NSString).doubleValue
    static let sharedAppDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate

    //MARK: - Min Max
    public struct MinMaxCharatersCount {
        
        static let HA_NAME_MIN_CHARS = 2
        static let HA_NAME_MAX_CHARS = 50
        static let HA_EMAIL_MAX_CHARS  = 250
        static let HA_MOBILE_MIN_LENGTH = 6
        static let HA_MOBILE_MAX_LENGTH = 10
        static let HA_PASSWORD_MIN_LENGTH = 6
        static let HA_PASSWORD_MAX_LENGTH = 18
        static let HA_SEARCH_TERM_MIN_CHAR =  1
        static let HA_PIN_CODE_LENGHT_MINLENGHT = 2
        static let HA_PIN_CODE_LENGHT_MAXLENGHT = 10
        static let HA_REPORT_TITLE_MAX_LENGTH = 100
        static let HA_REPORT_MAX_IMAGES_COUNT = 6
    }

   
}
