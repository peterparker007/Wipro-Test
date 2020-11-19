//
// Bhumesh_Purohit_Wipro_Exercise
//
//  Created by Bhumesh on 10/11/20.
//  Copyright © 2020 Bhumesh. All rights reserved.

import UIKit
import Reachability
extension AppDelegate {
    //MARK: - checkInternetConnection
    /*  checkInternetConnection as a root View Controller */
    public func checkInternetConnection(){
       
        do {
            self.reachability = try Reachability()
        } catch _ {
            self.reachability = nil
        }
        //declare this property where it won't go out of scope relative to your listener
        self.reachability!.whenReachable = { reachability in
            DispatchQueue.main.async {
                if (self.isNetworkScreenPresent == false) {
                   self.hideNetworkWindow()
                }
            }
        }
        self.reachability!.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                if self.isNetworkScreenPresent == true {
                    self.showNetworkwindow()
                }
                print("Not reachable")
            }
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reachabilityChanged(notification:)),
            name: NSNotification.Name.reachabilityChanged,
            object: nil
        )
        do {
            // Here we set up a NSNotification observer. The Reachability that caused the notification
            // is passed in the object parameter
            try self.reachability!.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    // notification fire as per reachability Changed
    @objc func reachabilityChanged(notification: NSNotification) {
        self.reachability! = notification.object as! Reachability
        
        switch self.reachability!.connection {
        case .wifi:
            self.isNetworkScreenPresent = false
            print("Reachable via WiFi")
        case .cellular:
           self.isNetworkScreenPresent = false
            print("Reachable via Cellular")
        case .none:
           self.isNetworkScreenPresent = true
            print("Network not reachable")
            
      case .unavailable:
            self.isNetworkScreenPresent = true
        
        }
    }
    /*  delay */
    func delay(delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    
    //MARK: - showNetworkwindow
    /*  showNetworkwindow */
    func showNetworkwindow() {
        self.isNetworkScreenPresent = false
          self.showAlertViewWithMessage("Wipro_Test", message: "No internet available")
      // let objNoInternetVc = UIStoryboard.noInternetVC()
     //  self.topViewController?.present(objNoInternetVc!, animated: true)
    }
    func showAlertViewWithMessage(_ title: String, message: String) {
           DispatchQueue.main.async {
               let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
               alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               AppDelegate.delegate().topViewController?.present(alertController, animated: true, completion: nil)
           }
       }
    func hideNetworkWindow() {
        isNetworkScreenPresent = true
        window?.rootViewController?.dismiss(animated: true)
        
    }
    
    //MARK: - topViewController
    var topViewController: UIViewController? {
            if #available(iOS 13, *) {
                return  topViewController(withRootViewController: UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController)
            } else {
                return topViewController(withRootViewController: UIApplication.shared.keyWindow?.rootViewController)
        }
    }
    // set topViewController
    func topViewController(withRootViewController rootViewController: UIViewController?) -> UIViewController? {
        if (rootViewController is UITabBarController) {
            let tabBarController1 = rootViewController as? UITabBarController
            return topViewController(withRootViewController: tabBarController1?.selectedViewController)
        } else if (rootViewController is UINavigationController) {
            let navigationController = rootViewController as? UINavigationController
            return topViewController(withRootViewController: navigationController?.visibleViewController)
        } else if rootViewController?.presentedViewController != nil {
            let presentedViewController: UIViewController? = rootViewController?.presentedViewController
            return topViewController(withRootViewController: presentedViewController)
        } else {
            return rootViewController
        }
    }
}
