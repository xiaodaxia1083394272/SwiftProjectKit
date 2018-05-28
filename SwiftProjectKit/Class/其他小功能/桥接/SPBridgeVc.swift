//
//  SPBridgeVc.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/5/28.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPBridgeVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        


    }
    
    @IBAction func clickSwiftCallOcBtn(_ sender: Any) {
        
        
        let ocVC = SPTestBriage()
        self.navigationController?.present(ocVC, animated: true, completion: {
            
            ocVC.swiftCallOC()
            
        })
    }
    
}
