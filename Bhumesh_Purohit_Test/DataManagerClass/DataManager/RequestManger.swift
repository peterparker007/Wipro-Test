//
// Bhumesh_Purohit_Wipro_Exercise 
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.

import UIKit
import Foundation

public func isNull(_ someObject: AnyObject?) -> Bool {
    guard let someObject = someObject else {
        return true
    }
    return (someObject is NSNull)
}

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

class RequestManger : NSObject {    
    var task:URLSessionDataTask?
    
    open class var sharedManager: RequestManger {
        struct Static {
            static let instance: RequestManger = RequestManger()
        }
        return Static.instance
    }
    func jsonParser(completionHandler:@escaping (_ success:Bool, _ data: NSDictionary?) -> Void) {
        let urlPath = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        guard let endpoint = URL(string: urlPath) else {
            print("Error creating endpoint")
            return
        }
        URLSession.shared.dataTask(with: endpoint) { (data, response, error) in
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let string = String(data: data, encoding: String.Encoding.isoLatin1) else {
                    throw JSONError.NoData
                }
                print(string)
                guard let dict = self.convertToDictionary(text: string) else {
                    throw JSONError.ConversionFailed
                }
                completionHandler(true, dict as NSDictionary)
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
        }.resume()
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
