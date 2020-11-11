//
//  Constants.swift
// Bhumesh_Purohit_Wipro_Exercise
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.

import Foundation
import UIKit

let APPDELEGATE  = UIApplication.shared.delegate as! AppDelegate

// ====================================================================== //
// This is for Screen Resolution
// ====================================================================== //
let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let IS_RETINA = UIScreen.main.scale >= 2.0

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH <= 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

// ====================================================================== //
// Save all User Defaults values
// ====================================================================== //


enum NavType : Int {
    case kNavTypeOther
    case kNavTypeBidder
}

struct Constants {
    
    static let DEFAULT_SCREEN_RATIO: CGFloat = 375.0
    
    static let PASSWORD_REGEX: String = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,20}$"
    static let NAME_REGEX: String = "^[a-zA-Z0-9]{1,15}$"
    
    static let BASE_URL = Constants.apiBaseURL()
    
    static let kShowBoardingForFirstTime = "show_boarding_for_first_time"
    
    static func apiBaseURL() -> String {
        return ConfigurationManager.sharedManager().APIEndPoint()
    }
    static func apiKMLURL() -> String {
        return ConfigurationManager.sharedManager().KMLURLPath()
    }
    static func apiRouteURL() -> String {
        return ConfigurationManager.sharedManager().RouteURLPath()
    }
   
    
    static let SCREEN_RATIO: CGFloat = UIScreen.main.bounds.width/375
    
    struct Urls {
        static let termsAndConditons = Constants.Urls.getURL("pages/seeker-terms")
        static let termsAndConditonsSeeker = Constants.Urls.getURL("pages/seeker-terms")
        static let termsAndConditonsProvider = Constants.Urls.getURL("pages/provider-terms")
        static let privacyPolicy = Constants.Urls.getURL("pages/seeker-terms")
        static let aboutUs = Constants.Urls.getURL("user/aboutUs")
        static func getURL(_ methodName: String) -> String {
            return Constants.apiBaseURL() + "/" + methodName
        }
    }
    //    asxpp5062c25111973
    // MARK: APIServiceMethods
    struct APIServiceMethods {
        
        /* == Login API  == */
        static let userData = Constants.APIServiceMethods.apiURL("facts.json") //
        

       
        static func apiURL(_ methodName: String) -> String {
            return ConfigurationManager.sharedManager().APIEndPoint() + "/" + methodName
        }
        
        static func imgURL(_ methodName: String) -> String {
            return ConfigurationManager.sharedManager().imageURLPath() + methodName
        }
    }
    
    struct CellIdentifiers {
        // SideMenu Cell
        static let kCell = "Cell" // sidemenu cell
    }
    
    struct TableViewRowsCount {
        static let kPostJob = 14
    }
    
    struct StoryboardIdentifiers {
        static let kUploadVC = "APUploadVC"
    }
    
    struct notificationCenterName {
       
    }
}
