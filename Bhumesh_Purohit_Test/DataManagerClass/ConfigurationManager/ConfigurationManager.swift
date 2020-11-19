//
//  ConfigurationManager.swift
// Bhumesh_Purohit_Wipro_Exercise 
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.

import UIKit

final class ConfigurationManager: NSObject {
    
    var environment: NSDictionary!
    
    // MARK: - Singleton Instance
    fileprivate static let _sharedManager = ConfigurationManager()
    
    class func sharedManager() -> ConfigurationManager {
        return _sharedManager
    }
    fileprivate override init() {
        super.init()
        // customize initialization
        initialize()
    }
    // MARK: Private Method
    
    fileprivate func initialize () {
        
        var environments: NSDictionary?
        if let envsPlistPath = Bundle.main.path(forResource: "Environments", ofType: "plist") {
            environments = NSDictionary(contentsOfFile: envsPlistPath)
        }
        self.environment = environments!.object(forKey: "Development") as? NSDictionary//currentConfiguration()        
        if (self.environment == nil) {// || self.configDict == nil
            assertionFailure(NSLocalizedString("Unable to load application configuration", comment:"Unable to load application configuration"))
        }
    }
}

// ConfigurationManager Extension
extension ConfigurationManager {
    
    // MARK: - Public Methods
    func currentConfiguration () -> String {
        let configuration = Bundle.main.infoDictionary?["Development"] as? String
        return configuration!
    }
    func APIEndPoint () -> String {
        let configuration = self.environment!["APIEndPoint"]
        return (configuration)! as! String
    }
}
