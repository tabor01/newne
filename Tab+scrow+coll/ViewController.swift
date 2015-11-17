//
//  ViewController.swift
//  Tab+scrow+coll
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ggvc = GGTableViewController()
        let tabV = ggvc.view
        view.addSubview(tabV)
        tabV.frame = CGRect(x: 0, y: 100, width: 300, height: 300)
//        view.bringSubviewToFront(tabV)
        
        addChildViewController(ggvc)
        
    }

 

}

