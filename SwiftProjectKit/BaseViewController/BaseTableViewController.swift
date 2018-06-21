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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "fdaffajfafafaf")
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
          return self.titles.count;
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
         默认单元格样式没有 detailTextLabel 。
         您需要使用 .Value1 或 .Subtitle 作为 UITableViewCellStyle :
         pss_判断cell为空的写法貌似被废弃了，swift这写法真让人蛋疼
         */
        let cell = tableView.dequeueReusableCell(withIdentifier: mainCellIdentifier) ?? UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier:mainCellIdentifier)
            cell.selectionStyle = UITableViewCellSelectionStyle.gray;
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator;
            cell.textLabel?.numberOfLines = 0;
        
        print(String(format:"cell的地址___%p",cell))
        var labelText = "";
        if (indexPath.row < 9) {
            
            labelText = "0\(indexPath.row + 1) - \(self.titles[indexPath.row])"
        }else {
            labelText = "0\(indexPath.row) - \(self.titles[indexPath.row])"
        }
        cell.textLabel?.text = labelText;
        cell.detailTextLabel?.text = self.classNames[indexPath.row];//pss_屏
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
            if vc != nil {
              self.navigationController?.pushViewController(vc!, animated: true)
            }
            
        }
    }

}
