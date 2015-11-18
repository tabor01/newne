//
//  GGTableViewController.swift
//  Tab+scrow+coll
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit
//let wid = UIScreen.mainScreen().bounds.width
let rowHeight:CGFloat = 80
class GGTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = rowHeight
        //        tableView.sectionHeaderHeight = 10
        //        tableView.backgroundColor = UIColor.grayColor()
        tableView.registerClass(GGTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GGTableViewCell
        cell.contentLable.text = "----第\(indexPath.row)行"

        
        cell.scrollView.contentSize = CGSize(width: view.bounds.width*3, height: cell.bounds.height)
        for(var i = 1; i < 4; i++ ){
            
            let img = UIImageView()
            img.image = UIImage(named: "\(i).jpg")
            img.frame = CGRect(x: wid * (CGFloat(i-1)), y: 0, width: wid, height: rowHeight)
            cell.scrollView.addSubview(img)
            img.contentMode = UIViewContentMode.ScaleAspectFit
        }
        
        cell.backgroundColor = UIColor.brownColor()
        return cell
    }
    
    
}

//class GGTableViewCell: UITableViewCell{
//    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        prepareUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func prepareUI(){
//    
//        addSubview(collectView)
//        collectView.translatesAutoresizingMaskIntoConstraints = false
//        
//        collectView.frame = contentView.bounds
//        
//    }
//    
//    //cell中用collectView来实现
//    private lazy var collectView = UICollectionView()
//}
//
//class GGCollectView: UICollectionView{
//
//    let layout = UICollectionViewLayout()
//    let rect = CGRect(x: 0, y: 0, width: wid, height: rowHeight)
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    init() {
//        super.init(frame: CGRectZero, collectionViewLayout: layout)
//    }
//
//
//}
//
//class GGCollectViewCell:UICollectionViewCell{
//
//
//}


class GGTableViewCell: UITableViewCell{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareUI()
    }
    
    func prepareUI(){
        
        contentView.addSubview(scrollView)
        scrollView.addSubview(contentLable)
        contentView.addSubview(pageControl)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        contentLable.translatesAutoresizingMaskIntoConstraints = false
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[sv]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["sv" : scrollView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[sv]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["sv" : scrollView]))
        
        addConstraint(NSLayoutConstraint(item: pageControl, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -5))
        addConstraint(NSLayoutConstraint(item: pageControl, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        
        
    }
    
    
    
    lazy var contentLable:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFontOfSize(14)
        lbl.sizeToFit()
        return lbl
    }()
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.bounces = false
        sv.showsHorizontalScrollIndicator = false
        sv.pagingEnabled = true
        sv.delegate = self
        return sv
    }()
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.pageIndicatorTintColor = UIColor.redColor()
        pc.currentPageIndicatorTintColor = UIColor.greenColor()
        pc.sizeToFit()
        return pc
    }()
    
}

extension GGTableViewCell:UIScrollViewDelegate{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offSet = scrollView.contentOffset.x
        
        pageControl.currentPage = NSInteger(offSet / contentView.bounds.width)
    }
    
    
}
