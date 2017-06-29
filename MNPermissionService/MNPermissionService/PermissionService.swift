//
//  PermissionProtocol.swift
//  MNPermissionService
//
//  Created by Mike Nelson 80044 on 6/29/17.
//
//

import Foundation
import EventKit
import Contacts
import UIKit

public class PermissionService {
    fileprivate var messageInternal: String?
    fileprivate var titleInternal: String?
    fileprivate var service: PermissionService?
    
    fileprivate init(message: String, title: String) {
        self.messageInternal = message
        self.titleInternal = title
        
    }
    
    //    public class func create(service: ServicePermission) -> PermissionService {
    //        var result: PermissionService
    //
    //        switch service {
    //        case .calendar:
    //            result = CalendarPermission()
    //            break
    //        case .contact:
    //            result = ContactPermission()
    //            break
    //        }
    //
    //        return result
    //    }
    
}
