//
//  DataManager.swift
// Bhumesh_Purohit_Wipro_Exercise 
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.

import UIKit
import Alamofire
class DataManager: NSObject {
    
    open class var sharedManager: DataManager {
        struct Static {
            static let instance: DataManager = DataManager()
        }
        return Static.instance
    }
  
   //use this function and get your output
    
    public func GetData( completion: @escaping (_ result: NSDictionary) -> Void){
         if self.checkInternet() == true { // check Internet Connection
                    
        RequestManger.sharedManager.jsonParser() {
            (success:Bool, responseDict: NSDictionary?) in
            let dict : NSDictionary = NSDictionary();
            if success == true{
                let ResponceData = responseDict!["title"] as! String
                
                if (!ResponceData.isEmpty){ // for success response                    
                    RequestManger.sharedManager.task?.cancel()
                    completion(responseDict!)
                }
                else {
                    RequestManger.sharedManager.task?.cancel()
                    completion(dict)
                }
            }else{
                RequestManger.sharedManager.task?.cancel()
                self.showAlertViewWithMessage("Wipro_Test", message: "No data available") // server not response or server timeout
                completion(dict)
            }
        }
        }
    }
    func checkInternet()-> Bool {
        if APPDELEGATE.reachability!.connection == .unavailable {
            DispatchQueue.main.async {
                if APPDELEGATE.isNetworkScreenPresent == true {
                    APPDELEGATE.showNetworkwindow()
                }
            }
            return false
        }
        return true
    }
    func showAlertViewWithMessage(_ title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            AppDelegate.delegate().topViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}








