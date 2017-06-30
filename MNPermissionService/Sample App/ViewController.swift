//
//  ViewController.swift
//  Sample App
//
//  Created by Mike Nelson 80044 on 6/30/17.
//
//

import UIKit
import MNPermissionService


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapCalendar(_ sender: Any) {
        let service = MNPermissionService.create(service: .calendar)
        _ = service.requestAccess(service: .calendar)
    }


}

