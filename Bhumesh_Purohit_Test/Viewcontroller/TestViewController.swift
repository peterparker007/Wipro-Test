//
//  ViewController.swift
// Bhumesh_Purohit_Wipro_Exercise 
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.
//

import UIKit
import SDWebImage
class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView() // Tableview for display data
    var ArrData = [ApiData]() //Array for store api data
    private let refreshControl = UIRefreshControl() //Pull to refresh
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set Tableview properties
        
        self.tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.CellIdentifiers.kCell)
        
        //get bar height for set Y position of tableview
        let barHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        //set top content
        self.tableView.contentInset.top = 20
        // set frame
        self.tableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        self.tableView.tableFooterView = UIView()
        //Add tableview in main view
        view.addSubview(tableView)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(callWebservicesForGetData), for: .valueChanged)
        
        // Call webservice for get data
        self.callWebservicesForGetData()
    }
    // Memory Management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: Constants.CellIdentifiers.kCell)
        //for get data from modal Object
        let obj = ArrData[indexPath.row]
        
        //Set Title
        cell.textLabel?.text = obj.title
        
        //multiple line enable
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.clipsToBounds = true
        //Set Detail
        cell.detailTextLabel?.text = obj.strdescription
       // set image from url
        cell.imageView!.layer.cornerRadius = 25
           cell.imageView!.clipsToBounds = true
        cell.imageView?.sd_setImage(with: URL(string: obj.imageHref ), placeholderImage: UIImage(named: "Placeholder"))
        if IS_IPAD{
             cell.imageView?.image = imageWithImage( image: (cell.imageView?.image)!, scaledToSize: CGSize(width: 125, height: 125))
            cell.imageView!.layer.cornerRadius = 40
        }
        else{
        cell.imageView?.image = imageWithImage( image: (cell.imageView?.image)!, scaledToSize: CGSize(width: 50, height: 50))
        }
       
        return cell
    }
    //image size modification
  func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
      
      UIGraphicsBeginImageContext(newSize)
      image.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return newImage!.withRenderingMode(.alwaysOriginal)
  }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return data count
        return ArrData.count
    }
    // if Cell select then this event is call
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


