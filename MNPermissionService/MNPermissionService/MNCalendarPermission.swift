//
//  MNCalendarPermission.swift
//  MNPermissionService
//
//  Created by Mike Nelson 80044 on 6/29/17.
//
//

import Foundation
import EventKit
import UIKit

class MNCalendarPermission: MNPermissionService, MNPermissionFactory {
    typealias EntityType = EKEntityType
    typealias StoreType = EKEventStore
    
    var store = EKEventStore()
    var entity = EKEntityType.event
    var message: String = "Without access to the Calendar Events some features of the app may not function correctly"
    var title = "Calendar Event Settings"
    
    internal init() {
        super.init(message: message, title: title)
    }
    
    func requestAccess() -> (Bool) {
        if EKEventStore.authorizationStatus(for: .event) == EKAuthorizationStatus.denied {
            repromptUserOfServiceNeed()
        } else {
            store.requestAccess(to: entity) { (accessGranted, error) in
                if error != nil {
                    print("Error requesting Access")
                }
            }
        }
        
        return false
    }
    
}
