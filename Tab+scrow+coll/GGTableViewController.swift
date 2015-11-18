//
//  GGTableViewController.swift
//  Tab+scrow+coll
//
//  Created by apple on 15/11/17.
//  Copyright © 2015年 tabor. All rights reserved.
//

import UIKit

let rowHeight:CGFloat = 180
let collectionViewItemNumber = 3
let reuseIdentifier = "cell"
class GGTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = rowHeight
//        print(UIScreen.mainScreen().bounds)
        tableView.registerClass(GGTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! GGTableViewCell

//        cell.collectView.contentSize = CGSize(width: wid * (CGFloat(collectionViewItemNumber)), height: 0)
        cell.collectView.scrollEnabled = true

        cell.backgroundColor = UIColor.brownColor()
//        print(cell.pageControl.frame)
        return cell
    }
    
    
}
// MARK: - 自定义tableViewCell
class GGTableViewCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        prepareUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareUI(){
    
        addSubview(collectView)
        addSubview(pageControl)
        
        collectView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        collectView.bounces = false
        collectView.pagingEnabled = true
        
        let views = [
        
            "cv" : collectView,
            "pc" : pageControl
        
        ]
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[cv]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[cv]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
//        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[pc]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views))
        
        addConstraint(NSLayoutConstraint(item: pageControl, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: pageControl, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -20))
        
//        bringSubviewToFront(pageControl)
        
//        print(pageControl.frame)
    }
    
    //cell中用collectView来实现
    private lazy var collectView = GGCollectView()
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.grayColor()
        pc.currentPageIndicatorTintColor = UIColor.greenColor()
        pc.sizeToFit()
//        pc.bounds.size = CGSize(width: 100, height: 20)
//        pc.bounds = CGRect(x: 0, y: 0, width: 100, height: 20)
        pc.numberOfPages = collectionViewItemNumber
        return pc
    }()
}
// MARK: - collectionView
class GGCollectView: UICollectionView{


    private var layout = GGCollectionViewFlowLayout()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init() {
        super.init(frame: CGRectZero, collectionViewLayout: layout)

        dataSource = self
        delegate = self
        backgroundColor = UIColor.greenColor()
        
        registerClass(GGCollectViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }


}

extension GGCollectView: UICollectionViewDelegate{

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let cell: GGTableViewCell = scrollView.superview as! GGTableViewCell
//        cell.pageControl.
        let widthCurrent = cell.collectView.contentOffset.x
        
                print(cell.collectView.contentOffset)
                cell.pageControl.currentPage = NSInteger(widthCurrent / wid)
    }

}

// MARK: - 数据源方法, 指定item的数量与Cell
extension GGCollectView: UICollectionViewDataSource{

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewItemNumber
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! GGCollectViewCell
        cell.img.image = nil
        cell.backgroundColor = UIColor.randomColor()
        cell.img.frame = CGRect(x: wid * (CGFloat(indexPath.item)), y: 0, width: wid, height: rowHeight)
        cell.img.image = UIImage(named: "\(indexPath.item + 2)")
        cell.img.contentMode = UIViewContentMode.ScaleAspectFit
        cell.btn.setTitle("第\(indexPath.item)列", forState: UIControlState.Normal)

        return cell
    }
}


// MARK: - collection的Cell部分： 一张图片，一个按钮
class GGCollectViewCell:UICollectionViewCell{
    
    var img: UIImageView = {
        let img = UIImageView()
        return img
    }()
    var btn: UIButton = {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 10, width: 100, height: 30)
        return btn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    func prepareUI(){
        addSubview(img)
        img.addSubview(btn)
    
        img.translatesAutoresizingMaskIntoConstraints = false
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        img.frame = contentView.frame
        btn.center = img.center
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[img]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["img" : img]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[img]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["img" : img]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[btn]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["btn" : btn]))
        addConstraint(NSLayoutConstraint(item: btn, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: img, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))

    }
    
}

class GGCollectionViewFlowLayout: UICollectionViewFlowLayout{

    override init() {
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        itemSize = CGSize(width: wid, height: rowHeight)
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
    }

   
}
