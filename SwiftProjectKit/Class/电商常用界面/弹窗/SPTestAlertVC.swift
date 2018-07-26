//
//  SPTestAlertVC.swift
//  SwiftProjectKit
//
//  Created by buyiyang on 2018/7/26.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class SPTestAlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickBtn(_ sender: Any) {
        UIView.animate(withDuration: 5, delay: 1, options: .curveEaseInOut, animations: {

        }) { (true) in
            self.dismiss(animated: false, completion: nil)

        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
