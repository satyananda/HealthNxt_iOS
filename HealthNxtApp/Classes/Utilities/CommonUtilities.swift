//
//  CommonUtilities.swift
//  HealthAdvisor
//
//  Created by Satyanand T on 16/10/17.
//  Copyright © 2017 KaaraInfoSystems. All rights reserved.
//

import UIKit
import AVFoundation


class CommonUtilities: NSObject {
    
    static let sharedInstance = CommonUtilities()
    
    // MARK: Appdelegate
    //Returens the appdelegate instance
    class func appDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: Reachability Checks
    class func isInternetConnectionAvailable() -> Bool{
        
        return true
    }
    
    // MARK: Document Path
    class func getDocumentPath() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory: String = paths[0]
        return documentsDirectory
    }
   
    
    // MARK: Validations Email
    class func isValidEmail(emailStr: String) -> Bool {
        
        // print("validate calendar: \(emailStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailStr)
    }
    
    class func validateMobileNumber(mobileString: String) -> Bool {
        
        let numRegEx = "^((\\+91)|0?)[789]{1}[0-9]{6,12}$"
        let numberTest = NSPredicate.init(format: "SELF MATCHES %@", numRegEx)
        let b = numberTest.evaluate(with: mobileString)
        if b {
            return true
        }
        return false
        
    }
    class func addCornersToTheView(rect: CGRect, corners: UIRectCorner, cornerRadii: CGSize, toView: UIView) {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: cornerRadii)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        toView.layer.mask = maskLayer
    }

    class func validateMobileNumberForZeros(mobileString: String) -> Bool{
    
        if mobileString.first == "0" {
            return false
        }
        return true
    }
    
    class func validatePassword(_ password: String) -> Bool {
        
        let specialCharacterString = "!~`@#$%^&*-+();:={}[],.<>?\\/\"\'"
        let specialCharacterSet = NSCharacterSet(charactersIn: specialCharacterString)
        
        if password.count >= HAConstants.MinMaxCharatersCount.HA_PASSWORD_MIN_LENGTH {
            var i = 0
            var alphabetBool: Bool = false
            var numericBool: Bool = false
            var splCharacterBool: Bool = false

            if !alphabetBool {
                if password.rangeOfCharacter(from: CharacterSet.letters) != nil {
                    alphabetBool = true
                }
            }
            if !numericBool {
                if password.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil {
                    numericBool = true
                }
            }

            for codeUnit in password.utf16 {
                
                if  !splCharacterBool {
                    splCharacterBool = specialCharacterSet.characterIsMember(codeUnit)
                }

                i = i+1

            }
            
            if alphabetBool && splCharacterBool && numericBool {
                return true
            }
            
        }
        return false
    }
    
    class func isValidDigits(_ string: String) -> Bool {
        //mobile validation
        let numberRegEx = "[0-9]"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        let b: Bool = numberTest.evaluate(with: string)
        if b {
            return true
        }
        return false
    }
    
    class func isValidMobileNumberforTenDigits(mobileString: String) -> Bool {
        //mobile validation
        let numberRegEx = "[0-9]{10}"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        let b: Bool = numberTest.evaluate(with: mobileString)
        if b {
            return true
        }
        return false
    }
    
    class func isValidURLAddress(_ urlString: String) -> Bool {
        let finalURL = URL(string: urlString)
        let urlRegEx = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&amp;=]*)?"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        return urlTest.evaluate(with: urlString) && finalURL != nil && finalURL?.host! != nil && finalURL?.scheme! != nil && UIApplication.shared.canOpenURL(finalURL!)
    }
    
    
    class func isValidPinCode(_ pinCode: String) -> Bool {
        //String with: alphabets, Numbers and - character set for International Pincode formate
        
        if pinCode.count == 0 {
            return false
        }
        
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-")
        if pinCode.rangeOfCharacter(from: characterset.inverted) != nil {
            print("****INVALID PIN CODE INCORRECT*****")
            return false
        }
        else {
            print("****VALID PIN CODE*****")
        }
        
        return true
        
    }
    
    
    //////////////////////////////
    // MARK: Date Related
    class func getTicksFrom(_ dateToBeConverted: Date) -> NSNumber {
        
        var dateTicks: NSNumber?
        dateTicks = Double(dateToBeConverted.timeIntervalSince1970 * 10000000 + 621355968000000000) as NSNumber
        return dateTicks!
    }
    
    class func getDateForEpochDate(_ epochTime: NSNumber) -> Date {
        
        let epochTimeInterval: TimeInterval = CDouble(truncating: epochTime) - 621355968000000000
        let actualDate = Date(timeIntervalSince1970: epochTimeInterval / 10000000)
        return actualDate
    }
    
    class func getDateStringForEpochDateNotificationTabFormate(epochTime: NSNumber) -> String {
        
        let epochTimeInterval = (epochTime.doubleValue)-621355968000000000
        let actualDate = NSDate.init(timeIntervalSince1970: epochTimeInterval/10000000)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        let calendar = Calendar.current
        let component = calendar.dateComponents([.second,.minute,.hour,.weekOfYear,.day,.month,.year], from: actualDate as Date, to: Date())
        
        if component.year! > 0 || component.month! > 0 {
            
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: actualDate as Date)
        } else if component.weekOfYear! > 0 {
            
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: actualDate as Date)
            
        } else if component.day! > 0 {
            
            if component.day! > 1 {
                
                dateFormatter.dateFormat = "MMM dd, yyyy"
                return dateFormatter.string(from: actualDate as Date)
                
            } else {
                dateFormatter.dateFormat = "MMM dd, yyyy"
                return dateFormatter.string(from: actualDate as Date)
            }
        } else {
            
            if component.hour! >= 1 {
                
                if component.hour! == 1
                {
                    return String(format: "%d hr ago", component.hour!)
                }
                return String(format: "%d hrs ago", component.hour!)
                
            } else if component.minute! >= 1{
                
                if component.minute! == 1
                {
                    return String(format: "%d min ago", component.minute!)
                }
                return String(format: "%d mins ago", component.minute!)
                
            } else
            {
                return "Just now"
            }
        }
    }
    
    class func convertUTCTimeToLocalTime(utcTime_String: String,WithFormat format: String) -> String {
        
        let _interval = UInt64(utcTime_String)
        let timeInterval = _interval!-621355968000000000
        let actualDate = Date.init(timeIntervalSince1970: TimeInterval(timeInterval/10000000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = format
        
        //        if UserDefaults.standard.object(forKey: "isHindi") as! Bool == true {
        //
        //            dateFormatter.locale = NSLocale(localeIdentifier: "hi") as Locale!
        //        }
        //        else {
        //
        //            dateFormatter.locale = NSLocale(localeIdentifier: "eN") as Locale!
        //        }
        
        let dateString = dateFormatter.string(from: actualDate)
        
        return dateString
        
    }
    
    class func convertUTCTimeToLocalTime(utcTime_String: String) -> String {
        
        let _interval = UInt64(utcTime_String)
        let timeInterval = _interval!-621355968000000000
        let actualDate = Date.init(timeIntervalSince1970: TimeInterval(timeInterval/10000000))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.system
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: actualDate)
        return dateString
    }
    
    class func convertUTCTimeToLocalTimeForDOB(utcTime_String: String) -> String {
        
        let responseDateFormatt = DateFormatter.init()
        responseDateFormatt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        responseDateFormatt.timeZone = TimeZone.init(secondsFromGMT: 0)
        
        let requiredDateFormat = DateFormatter.init()
        requiredDateFormat.dateFormat = "dd MMM yyyy"
        requiredDateFormat.timeZone = TimeZone.init(secondsFromGMT: 0)
        
        let dateFromStr = responseDateFormatt.date(from: utcTime_String )
        
        let dateString = requiredDateFormat.string(from: dateFromStr ?? Date.init())
        
        return dateString
    }

    class func getTicksFromDate(dateToBeConverted: Date) -> NSNumber {
        
        let dt: Double = (dateToBeConverted.timeIntervalSince1970)*10000000+621355968000000000
        
        let dateTicks: NSNumber = NSNumber.init(value: dt)
        
        return dateTicks
    }
    
    //////////////////////////////

    
    //////////////////////////////
    // MARK: String Encode/Decode
    
    class func getCountofNumberOfCharacters(descriptionText: String) -> NSInteger {
        
        return descriptionText.count
    }
    
    func stringContainsEmoji(string: String) -> Bool {
        var containsEmoji = false
        for scalar in string.unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F:
                // Emoticons
                containsEmoji = true
            case 0x1F300...0x1F5FF:
                // Misc Symbols and Pictographs
                containsEmoji = true
            case 0x1F680...0x1F6FF:
                // Transport and Map
                containsEmoji = true
            case 0x2600...0x26FF:
                // Misc symbols, not all emoji
                containsEmoji = true
            case 0x2700...0x27BF:
                // Dingbats, not all emoji
                containsEmoji = true
            default: ()
            }
        }
        return containsEmoji
    }

    class func encodeString(toUniCode enStr: String) -> String {
        let dataenc: Data? = enStr.data(using: String.Encoding.nonLossyASCII)
        let encodevalue = String(data: dataenc!, encoding: String.Encoding.utf8)
        return encodevalue ?? ""
    }
    
    class func decodeString(fromUniCode deStr: String) -> String {
        if deStr.count > 0 {
            let dataDec: Data? = deStr.data(using: String.Encoding.utf8)
            let decodevalue = String(data: dataDec!, encoding: String.Encoding.nonLossyASCII)
            if decodevalue == nil {
                return deStr
            }
            return decodevalue ?? ""
        }
        return ""
    }
    ////////////////////////////
   
    
    ////////////////////////////
    // MARK: Identifires
    class func GetUUID() -> String {
        
        return UUID().uuidString
    }
    
   
    ////////////////////////////
    // MARK: Image Compression & Type
    
    @objc class func resizeImage(with sourceImage: UIImage, scaledToWidth scaleHeight: Float) -> UIImage {
        let oldHeight = Float(sourceImage.size.height)
        let scaleFactor: Float = scaleHeight / oldHeight
        let newHeight = Float(sourceImage.size.width) * Float(scaleFactor)
        let newWidth: Float = oldHeight * scaleFactor
        UIGraphicsBeginImageContext(CGSize(width: CGFloat(newWidth), height: CGFloat(newHeight)))
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: CGFloat(newWidth), height: CGFloat(newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
    @objc class func resizeImage(with sourceImage: UIImage, scaledTo scaleSize: CGSize) -> UIImage {
        var newHeight: Float = 0.0
        var newWidth: Float = 0.0
        var scaleFactor: Float = 1.0
        if sourceImage.size.width >= sourceImage.size.height {
            scaleFactor = Float((scaleSize.width / sourceImage.size.width))
        }
        else if sourceImage.size.width > scaleSize.width {
            scaleFactor = Float((scaleSize.width / sourceImage.size.width))
        }
        else {
            return sourceImage
        }
        
        newHeight = Float(sourceImage.size.height) * Float(scaleFactor)
        newWidth = Float(sourceImage.size.width) * Float(scaleFactor)
        UIGraphicsBeginImageContext(CGSize(width: CGFloat(newWidth), height: CGFloat(newHeight)))
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: CGFloat(newWidth), height: CGFloat(newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }

    
    @objc class func generateVideoThumbnailImage(fromVideoURL videoURL: URL) -> UIImage {
        
        let asset = AVAsset(url: videoURL)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)
        
        var time = asset.duration
        time.value = min(time.value, 2)
        
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage.init(cgImage: imageRef)
        } catch {
            print("generateVideoThumbnailImage error")
            return UIImage()
        }
    }
    
    
    @objc class func getUniqueFileName(_ fileName: String) -> String {
        
        let nameF: String = "\(CommonUtilities.GetUUID())\(fileName)"
        return nameF
    }
    
    
    class func compressImage(_ image: UIImage, toMaxSize maxSize: CGSize) -> UIImage {
        var actualHeight = Float(image.size.height)
        var actualWidth = Float(image.size.width)
        let maxHeight = Float(maxSize.height)
        let maxWidth = Float(maxSize.width)
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
                
            }
        }
        let rect = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let resultantImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultantImage!
    }
    class func imageType(imgData: NSData) -> String {
        
        var c = [UInt8](repeating: 0, count: 1)
        imgData.getBytes(&c, length: 1)
        
        let ext: String
        
        switch c[0] {
        case 0xFF:
            
            ext = "image/jpeg"
            
        case 0x89:
            
            ext = "image/png"
        case 0x47:
            
            ext = "image/gif"
        case 0x49, 0x4D :
            ext = "image/bmp"
        default:
            ext = "" //unknown
        }
        
        return ext
    }
    
    
    
    ////////////////////////////

    ////////////////////////////
    // MARK: Deserialize JSON
    class func deserializeJSON(_ jsonString: String) -> [AnyHashable: Any] {
        let JSONData: Data? = jsonString.data(using: String.Encoding.utf8)
        //var error: Error?
        let json = try? JSONSerialization.jsonObject(with: JSONData!, options: .mutableContainers) as? [AnyHashable: Any]
        
        return (json ?? [AnyHashable: Any]())!
    }
    
    class func dictToJson(dict: [AnyHashable: Any]) -> String {
       
        let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)!
        print(jsonString)
        
        return jsonString
        
    }
    ////////////////////////////

    
    ////////////////////////////
    // MARK: ----
    class func addDropDownIconAtRightSideForTextField(textfield: UITextField?) {
        
        let dropDownImageView = UIImageView(image: UIImage(named: "dropdown"))
        dropDownImageView.frame = CGRect(x: 0, y: 0, width: 25, height: 30)
        dropDownImageView.contentMode = UIView.ContentMode.scaleAspectFit
        textfield?.rightView = dropDownImageView
        textfield?.rightViewMode = UITextField.ViewMode.always
        
    }
    ////////////////////////////

    ////////////////////////////
    // MARK: APP Version as String
    class func getAppVersionInfo() -> String {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        let build = Bundle.main.object(forInfoDictionaryKey: (kCFBundleVersionKey as String?)!) as? String
        return "V\(version!)(\(build!))"
    }
    
   
}
