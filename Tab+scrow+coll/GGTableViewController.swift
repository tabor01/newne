//
//  GGTableViewController.swift
//  Tab+scrow+coll
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

class GGTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 80
        tableView.sectionHeaderHeight = 10
        tableView.backgroundColor = UIColor.grayColor()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }



//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//
//        return 3
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        cell.textLabel?.text = "第\(indexPath.row)行"

        cell.backgroundColor = UIColor.brownColor()
        return cell
    }
    
//    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10
//    }
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 10
//    }

}

class GGTableViewCell: UITableViewCell{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(contentLable)
        contentLable.frame = contentView.frame
        
    }
    
    
    
    lazy var contentLable:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFontOfSize(14)
        lbl.sizeToFit()
        return lbl
    }()


}
