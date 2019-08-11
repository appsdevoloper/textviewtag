//
//  SecondViewController.swift
//  Tag
//
//  Created by Apple on 10/08/19.
//  Copyright © 2019 Revolut. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        UserDefaults.standard.set("Daily", forKey: "second")
        self.dismiss(animated: true, completion: nil)
    }
}
