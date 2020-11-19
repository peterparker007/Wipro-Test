//
//  CountryViewModal.swift
//  Bhumesh_Purohit_Test
//
//  Created by Bhumesh on 19/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.
//

import UIKit

class CountryViewModal: NSObject {
    var arrModel = [AboutCountryData]()
    public init?(arrdata: NSArray) {
        for addDict in arrdata {
            let obj = AboutCountryData(dictionary: addDict as! NSDictionary)!
            self.arrModel.append(obj)
        }        
    }
}
