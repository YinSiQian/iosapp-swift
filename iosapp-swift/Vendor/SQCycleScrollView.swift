//
//  SQCycleScrollView.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/21.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit


@objc protocol SQCycleScrollViewDelegate: NSObjectProtocol {
    @objc optional
    
    func cycleScrollView(_ cycleScrollView: SQCycleScrollView, didSelectedItem: Int)
}


class SQCycleScrollView: UIView {
    
    typealias didItemBlock = (_ index: Int) -> ()
    
    fileprivate var block: didItemBlock?

    public weak var delegate: SQCycleScrollViewDelegate?
    
    fileprivate var totalCount = 0
    
    fileprivate var timer: Timer?
    
    var isAuto = true {
        willSet {
            invalidateTimer()
            if newValue {
                print(newValue)
                createTimer()
            }
        }
    }
    
    fileprivate let reuse_id = "reuse_id"
    
    fileprivate var col: UICollectionView!
    
    var image_urls = [String]() {
        willSet {
            for url in newValue {
                guard url.hasPrefix("http") || url.hasPrefix("https") else {
                    assertionFailure("this url is error foramt")
                    return
                }
            }
            if newValue.count != 1 && !newValue.isEmpty {
                self.totalCount = newValue.count * 100
            } else {
                self.totalCount = 1
                self.isAuto = false
            }
            let auto = self.isAuto
            self.isAuto = auto
            self.col.reloadData()
        }
    }
    
    var autoTime = 3.0 {
        didSet {
            let auto = self.isAuto
            self.isAuto = auto
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
    
    convenience init(frame: CGRect, imagesURL: [String], block: @escaping didItemBlock) {
        self.init(frame: frame, imagesURL: imagesURL)
        self.block = block
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
      let timer = Timer.scheduledTimer(withTimeInterval: autoTime, repeats: true, block: {
           [weak self] (_) in
            if !(self?.isAuto)! {
                self?.timer?.invalidate()
                return
            }
            self?.autoScroll()
        })
        self.timer = timer
        RunLoop.main.add(self.timer!, forMode: RunLoopMode.commonModes)
    }
    
    private func autoScroll() {
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
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        print(timer as Any)
        timer = nil
        print("cycle view is dealloc")
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
        let index = indexPath.item % image_urls.count
        self.block?(index)
        self.delegate?.cycleScrollView!(self, didSelectedItem: index)
    }
}

extension SQCycleScrollView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuse_id, for: indexPath) as! CycleScrollCell
        let index = indexPath.item % image_urls.count
        let url = image_urls[index]
        cell.imageView?.sd_setImage(with: url.url())
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
            self.timer?.fire()
        }
    }
}


