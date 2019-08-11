//
//  FirstViewController.swift
//  Tag
//
//  Created by Apple on 10/08/19.
//  Copyright © 2019 Revolut. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeAction(_ sender: Any) {
      UserDefaults.standard.set("24th-July,2019", forKey: "first")
      self.dismiss(animated: true, completion: nil)
    }
}
