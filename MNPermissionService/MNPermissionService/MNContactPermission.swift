//
//  MNContactPermission.swift
//  MNPermissionService
//
//  Created by Mike Nelson 80044 on 6/29/17.
//
//

import Foundation
import Contacts
import UIKit

class MNContactPermission: MNPermissionService, MNPermissionFactory {
    typealias EntityType = CNEntityType
    typealias StoreType = CNContactStore
    
    var store = CNContactStore()
    var entity = CNEntityType.contacts
    var message = "I need this too"
    var title = "Contact Settings"
    
    internal init() {
        super.init(message: message, title: title)
    }
    
    func requestAccess() -> Bool {
        
        if CNContactStore.authorizationStatus(for: .contacts) == CNAuthorizationStatus.denied {
            repromptUserOfServiceNeed()
        } else {
            store.requestAccess(for: entity, completionHandler: {
                accessGranted, error in
                
                if error != nil {
                    print("Error requesting access")
                }
                
            })
        }
        
        return false
    }
    
    func repromptUserOfServiceNeed() {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: {
            action in
            
            let settingsURL = URL(string: UIApplicationOpenSettingsURLString)
            UIApplication.shared.open(settingsURL!, options: [:], completionHandler: nil)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        dialog.addAction(settingsAction)
        dialog.addAction(cancelAction)
        
        if var currentViewController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = currentViewController.presentedViewController {
                currentViewController = presentedViewController
            }
            currentViewController.present(dialog, animated: true, completion: nil)
        }
    }
}
