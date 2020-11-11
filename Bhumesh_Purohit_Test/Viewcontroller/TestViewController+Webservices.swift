//
//  TestViewController+Webservices.swift
// Bhumesh_Purohit_Wipro_Exercise 
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.
//

import UIKit

extension TestViewController{
    @objc func callWebservicesForGetData() {
        
        //remove all data while refresh
        self.ArrData.removeAll()        
        DataManager.sharedManager.GetData() { (dictResponse: NSDictionary) in
            DispatchQueue.main.async{
                print(dictResponse) // get response from webservices
                guard let arrdata = dictResponse["rows"] as? NSArray  else {
                    return
                }
                // set data in modal and set modal object onto array
                for addDict in arrdata {
                    let obj = ApiData(dictionary: addDict as! NSDictionary)!
                    self.ArrData.append(obj)
                }
                self.tableView.reloadData()
            }
        }
    }
}
