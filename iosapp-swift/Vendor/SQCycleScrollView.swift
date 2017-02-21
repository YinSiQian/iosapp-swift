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
    
    fileprivate var image_urls = [String]() {
        willSet {
            for url in newValue {
                guard url.hasPrefix("http") || url.hasPrefix("https") else {
                    assertionFailure("url has error foramt")
                    return
                }
                if newValue.count != 1 {
                    self.totalCount = newValue.count * 100
                    self.isAuto = false
                } else {
                    self.totalCount = 1
                }
            }
        }
    }
    
    var autoTime = 0.0 {
        didSet {
            if self.totalCount != 1 {
                self.createTimer()
            }
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
        if self.totalCount != 1 {
            col.scrollToItem(at: IndexPath.init(index: totalCount / 2), at: .centeredHorizontally, animated: false)
        }
    }
    
    private func setupSubviews() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: self.frame.width, height: self.frame.width)
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
        timer = Timer.scheduledTimer(withTimeInterval: autoTime, repeats: true, block: {
            (_) in
            self.autoScroll()
        })
    }
    
    private func autoScroll() {
        var index = currentIndex() + 1
        if index >= totalCount {
            index = totalCount / 2
            col.scrollToItem(at: IndexPath.init(index: index), at: .centeredHorizontally, animated: false)
            return
        }
        col.scrollToItem(at: IndexPath.init(index: index), at: .centeredHorizontally, animated: true)
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
        return totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse_id, for: indexPath) as! CycleScrollCell
        let urlString = image_urls[indexPath.item]
        cell.imageView?.kf.setImage(with: urlString.url())
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
