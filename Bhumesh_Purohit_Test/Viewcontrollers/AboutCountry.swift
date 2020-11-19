//
//  ViewController.swift
// Bhumesh_Purohit_Wipro_Exercise 
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.
//

import UIKit
import SDWebImage
class AboutCountry: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView() // Tableview for display data
    var ObjCountryViewModal:CountryViewModal? // object of viewModal
     let refreshControl = UIRefreshControl() //object for Pull to refresh
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
        if (ObjCountryViewModal?.arrModel.count)! > 0
        {
            let obj = ObjCountryViewModal?.arrModel[indexPath.row]
            //Set Title
            cell.textLabel?.text = obj?.title
            
            //multiple line enable
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.clipsToBounds = true
            //Set Detail
            cell.detailTextLabel?.text = obj?.strdescription
            // set image from url
            
            var placedImage: UIImage!
            cell.imageView!.clipsToBounds = true
            // check if imagepath is blank or nil
            if obj!.imageHref == ""{
                placedImage = UIImage(named: "Placeholder")
                cell.imageView?.image = placedImage
                if IS_IPAD{
                    //set image frame if it is iPad
                    cell.imageView?.image = self.imageWithImage( image: placedImage!, scaledToSize: CGSize(width: Constants.ImageHeightWidth.kWidthIPad, height: Constants.ImageHeightWidth.kHeightIPad))
                }
                else{
                    //set image frame if it is iPhone
                    cell.imageView?.image = self.imageWithImage( image: placedImage!, scaledToSize: CGSize(width: Constants.ImageHeightWidth.kWidthIPhone, height: Constants.ImageHeightWidth.kHeightIPhone))
                }
            }
            else{
                cell.imageView?.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.imageView?.sd_setImage(with: URL(string: obj!.imageHref), placeholderImage: UIImage(named: "Placeholder"))
                if IS_IPAD{
                    //set image frame if it is iPad
                    cell.imageView?.image = self.imageWithImage( image:   (cell.imageView?.image!)!, scaledToSize: CGSize(width: Constants.ImageHeightWidth.kWidthIPad, height: Constants.ImageHeightWidth.kHeightIPad))
                    
                }
                else{
                    //set image frame if it is iPhone
                    cell.imageView?.image = self.imageWithImage( image: (cell.imageView?.image!)!, scaledToSize: CGSize(width: Constants.ImageHeightWidth.kWidthIPhone, height: Constants.ImageHeightWidth.kHeightIPhone))
                }
            }
        }
        return cell
    }
    //image size modification
    func imageWithImage(image: UIImage, scaledToSize newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0 ,y: 0 ,width: newSize.width ,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return data count
        return ObjCountryViewModal?.arrModel.count ?? 0 
    }
    // if Cell select then this event is call
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


