//
//  SQDiscoverViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class SQDiscoverViewController: UIViewController {
    
    var col: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        setChildViewController()
        setupSubviews()
    }
    
    func setChildViewController() {
        self.addChildViewController(CommunityViewController())
        self.addChildViewController(BBSLayoutViewController())
   }
    
    func setupSubviews() {
        
        let titleView = TitlesView.init(titles: ["推荐", "进入版面"]) {
            (index) in
            print(index)
            self.col.scrollToItem(at: IndexPath(row: index, section: 0), at: .left, animated: true)
        }
        navigationItem.titleView = titleView
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screen_width, height: screen_height - 64)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        var rect = view.bounds
        rect.origin.y = 64
        rect.size.height = screen_height - 64
        
        col = UICollectionView(frame: rect, collectionViewLayout: layout)
        col.backgroundColor = UIColor.white
        col.delegate = self
        col.dataSource = self
        col.isPagingEnabled = true
        view.addSubview(col)
        
        print(col.frame)
        
        col.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / screen_width)
        let view = self.navigationItem.titleView as! TitlesView
        view.selectedButton(with: index + 1)
    }

}

extension SQDiscoverViewController: UICollectionViewDelegate {
    
}

extension SQDiscoverViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let vc = self.childViewControllers[indexPath.item]
        cell.contentView.addSubview(vc.view)
        return cell
    }
}


