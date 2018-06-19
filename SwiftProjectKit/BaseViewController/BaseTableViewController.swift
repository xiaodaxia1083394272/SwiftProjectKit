//
//  BaseTableViewController.swift
//  SwiftProjectKit
//
//  Created by Macx on 2018/6/19.
//  Copyright © 2018年 HMRL. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    let mainCellIdentifier = "mainCellIdentifier";

    var titles = [String]()
    var classNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white;
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: mainCellIdentifier)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none;
    }

    func setupDataArr(dataArr : [[String]]) -> Void {
        
        var tempTitleArr = [String]()
        var tempNamesArr = [String]()
        
        for arr in dataArr{
            
            tempTitleArr.append(arr[0])
            tempNamesArr.append(arr[1])

        }
        self.titles = tempTitleArr
        self.classNames = tempNamesArr
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.titles.count;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mainCellIdentifier, for: indexPath)

        
        
        cell.selectionStyle = UITableViewCellSelectionStyle.gray;
        var labelText = "";
        if (indexPath.row < 9) {
            
            labelText = "0\(indexPath.row + 1) - \(self.titles[indexPath.row])"
        }else {
            labelText = "0\(indexPath.row) - \(self.titles[indexPath.row])"
        }
        cell.textLabel?.text = labelText;
        cell.textLabel?.numberOfLines = 0;
        cell.detailTextLabel?.text = self.classNames[indexPath.row];//pss_屏
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator;
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //类名
        var className : String = self.classNames[indexPath.row];
        
        // 注意: 如果是sb来搭建, 必须以 _UIStoryboard 结尾
        let classNameLength = (className as NSString).length;
        let storyBoardLength = ("_UIStoryboard" as NSString).length;
        let xibLength = ("_xib" as NSString).length;
        
        var suffixClassName = "";
        if (classNameLength > storyBoardLength) {
            suffixClassName = (className as NSString).substring(from: classNameLength - storyBoardLength)
        }
        
        if suffixClassName == "_UIStoryboard" {
            
            className = (className as NSString).substring(to: classNameLength - storyBoardLength)

                // 注意: 这个storyboard的名字必须是控制器的名字
            let storyBoard : UIStoryboard = UIStoryboard(name: className, bundle: nil)
            
            var cardVC : UIViewController = storyBoard.instantiateInitialViewController()!
            
             if cardVC != nil {
                    cardVC = storyBoard.instantiateViewController(withIdentifier: className);
            }
            cardVC.title = self.titles[indexPath.row];
            self.navigationController?.pushViewController(cardVC, animated: true)
            
        }else if ((className as NSString).substring(from:classNameLength - xibLength) ==  "_xib") {
            
            className = (className as NSString).substring(to:classNameLength - xibLength );
            
            let rootControl = NSClassFromString(className) as? UIViewController.Type

            let vc = rootControl?.init()
            
            vc?.title = self.titles[indexPath.row];
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }else {
            print("className = \(className)");
            let rootControl = NSClassFromString(className) as? UIViewController.Type
            
            let vc = rootControl?.init()
            
            vc?.title = self.titles[indexPath.row];
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }

}
