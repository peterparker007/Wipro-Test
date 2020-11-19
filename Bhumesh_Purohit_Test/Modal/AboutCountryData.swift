//
//  Data.swift
//  Bhumesh_Purohit_Test
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.
//

import UIKit

class AboutCountryData: NSObject {
    
    var title: String = "" // For set Title
    var strdescription: String = "" // For set Description
    var imageHref: String = "" // ImagePath
    
    public init?(dictionary: NSDictionary) {
        title = dictionary["title"] as? String ?? ""
        strdescription = dictionary["description"] as? String ?? ""
        imageHref = dictionary["imageHref"] as? String ?? ""
      //  print(imageHref)
    }
}
