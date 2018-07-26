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

    override func viewWillAppear(_ animated: Bool) {
        animatedShow()
    }
    

    @IBAction func clickBtn(_ sender: Any) {
//        UIView.animate(withDuration: 5, delay: 1, options: .curveEaseInOut, animations: {
//
//        }) { (true) in
//            self.dismiss(animated: false, completion: nil)
//
//        }
        
        animatedHide()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func animatedShow() {
        
//        self.backgroundView.wm_updateConstraints { (make) in
//
//            make.top(50).equal(self.navigationView).bottom()
//        }
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.layoutIfNeeded()
            
        })
    }
    
    func animatedHide() {
        
//        self.backgroundView.wm_updateConstraints { (make) in
//
//            make.top(UIScreen.main.bounds.height).equal(self.navigationView).bottom()
//        }
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.view.layoutIfNeeded()
            
        }, completion: { (_) in
            
            self.dismiss(animated: false)
        })
    }
    

}
