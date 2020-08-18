//
//  HAResponseCodes.swift
//  HealthAdvisor
//
//  Created by Satyanand T on 17/10/17.
//  Copyright © 2017 KaaraInfoSystems. All rights reserved.
//

//
//
//
import Foundation

public struct HAResponseCodes {
    
    
    //MARK: - Global response codes
    
   enum LoginAPIResponseCodes: Int {
       
       case Common_Success = 1005
       case Login_UserInOnBaord = 2014
       case Common_Unknown_User = 1055
       case Common_Internal_Server_Error = 1035
       case Common_Validation_Error = 1045
       case OTP_Invalid = 2135
       case OTP_Expired = 2155
   }

   
   enum RegisterDeviceAPIResponseCodes: Int {
       
       case Common_Success = 1005
       case Common_Internal_Server_Error = 1035
       case Common_Validation_Error = 1045
   }
   
   enum MediaType: Int {
       case Media_Type_Image = 1
       case Media_Type_Video = 2
   }

    
    
}
