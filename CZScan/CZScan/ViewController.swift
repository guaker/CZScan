//
//  ViewController.swift
//  CZScan
//
//  Created by chenzhen on 16/7/20.
//  Copyright © 2016年 huimeibest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.init(type: .Custom)
        button.frame = CGRectMake(100, 100, 100, 100)
        button.backgroundColor = UIColor.brownColor()
        button.addTarget(self, action: #selector(didButton), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didButton() {
        self.presentViewController(CZScanViewController(), animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

