//
//  SQCycleScrollView.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/21.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class SQCycleScrollView: UIView {

    fileprivate var totalCount = 0
    
    fileprivate var timer: Timer?
    
    var isAuto = true
    
    fileprivate let reuse_id = "reuse_id"
    
    fileprivate var col: UICollectionView!
    
    var image_urls = [String]() {
        willSet {
            for url in newValue {
                guard url.hasPrefix("http") || url.hasPrefix("https") else {
                    assertionFailure("url has error foramt")
                    return
                }
                if newValue.count != 1 {
                    self.totalCount = newValue.count * 100

                } else {
                    self.totalCount = 1
                    self.isAuto = false
                }
                self.col.reloadData()
            }
        }
    }
    
    var autoTime = 3.0 {
        didSet {
            self.createTimer()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    convenience init(frame: CGRect, imagesURL: [String]) {
        self.init(frame: frame)
        self.image_urls = imagesURL
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.totalCount != 1 && self.totalCount != 0  {
            col.scrollToItem(at: IndexPath.init(row: totalCount / 2, section: 0), at: UICollectionViewScrollPosition(), animated: false)
        }
    }
    
    private func setupSubviews() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: self.frame.width, height: self.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        col = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        col.backgroundColor = UIColor.clear
        col.delegate = self
        col.dataSource = self
        col.isPagingEnabled = true
        col.showsVerticalScrollIndicator = false
        col.showsHorizontalScrollIndicator = false
        self.addSubview(col)
    
        col.register(CycleScrollCell.self, forCellWithReuseIdentifier: reuse_id)
    }
    
    func createTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: {
           [unowned self] (_) in
            if !self.isAuto {
                self.timer?.invalidate()
                return
            }
            self.autoScroll()
        })
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    private func autoScroll() {
        print(#function)
        var index = currentIndex() + 1
        if index >= totalCount {
            index = totalCount / 2
            col.scrollToItem(at: IndexPath.init(row: index, section: 0), at: .left, animated: false)
            return
        }
        col.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionViewScrollPosition(), animated: true)
    }
    
    private func currentIndex() -> Int {
        return Int(col.contentOffset.x / self.frame.size.width)
    }
    
    func invalidateTimer() {
        if (timer != nil) {
            timer?.invalidate()
            timer = nil
        }
    }
}

class CycleScrollCell: UICollectionViewCell {
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView.init(frame: self.bounds)
        contentView.addSubview(imageView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SQCycleScrollView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension SQCycleScrollView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        return totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse_id, for: indexPath) as! CycleScrollCell
        var url = ""
        if totalCount == 1 {
            url = image_urls.first!
        } else {
            let index = indexPath.item % image_urls.count
            url = image_urls[index]
        }
        cell.imageView?.kf.setImage(with: url.url())
        return cell
    }
}

extension SQCycleScrollView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if isAuto {
            self.invalidateTimer()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isAuto {
            self.createTimer()
        }
    }
}
