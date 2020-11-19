//
//  TestViewController+Webservices.swift
// Bhumesh_Purohit_Wipro_Exercise 
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.
//

import UIKit

extension AboutCountry{
    @objc func callWebservicesForGetData() {
        
        DataManager.sharedManager.GetDataFromAPI() { (dictResponse: NSDictionary) in
            DispatchQueue.main.async{
            //    print(dictResponse) // get response from webservices
                guard let arrdata = dictResponse["rows"] as? NSArray  else {
                    return
                }
                 //remove all data while refresh
                self.ObjCountryViewModal?.arrModel.removeAll()
                // set data in modal
                self.ObjCountryViewModal = CountryViewModal(arrdata: arrdata)!
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}
