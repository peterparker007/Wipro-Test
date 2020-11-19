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

struct Constants {
    static let BASE_URL = Constants.apiBaseURL()
    static func apiBaseURL() -> String {
        return ConfigurationManager.sharedManager().APIEndPoint()
    }
    struct Urls {
        static func getURL(_ methodName: String) -> String {
            return Constants.apiBaseURL() + "/" + methodName
        }
    }
    // ====================================================================== //
    // MARK: APIServiceMethods
    // ====================================================================== //
    struct APIServiceMethods {
        /* == Get Data From Json API  == */
        static let userData = Constants.APIServiceMethods.apiURL("facts.json")
        static func apiURL(_ methodName: String) -> String {
            return ConfigurationManager.sharedManager().APIEndPoint() + "/" + methodName
        }
    }
    // ====================================================================== //
    // MARK: CellIdentifiers
    // ====================================================================== //
    struct CellIdentifiers {
        // Tableview Cell
        static let kCell = "Cell" // sidemenu cell
    }
    // ====================================================================== //
    // MARK: Image Height Width Constants
    // ====================================================================== //
    struct ImageHeightWidth {
        static let kHeightIPad = 125
        static let kWidthIPad = 125
        static let kHeightIPhone = 50
        static let kWidthIPhone = 50
    }
    // ====================================================================== //
    // MARK: Image CornerRadius Constants
    // ====================================================================== //
    struct ImageCornerRadius {
        static let kIPadCornerRadius = 40
        static let kIPhoneCornerRadius = 25
    }
}
