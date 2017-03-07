//
//  SQTweetsViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class SQTweetsViewController: UIViewController {

    lazy var modelArr = [PlaceModel]()
    
    var tableView: UITableView!
    
    var col: UICollectionView!
    
    var selectIndex = 0 {
        didSet {
            self.col.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        loadData()
    }
    
    func loadData() {
        SQNetworkManager.shared.GET(urlString: home_place, parameters: nil) {
            [unowned self] (success, json, error) in
            let data = json?["data"]
            for dict in data! {
                let model = PlaceModel.yy_model(with: dict.1.dictionaryObject!)
                self.modelArr.append(model!)
            }
            self.setupView()
            self.tableView.selectRow(at: IndexPath.init(row: self.selectIndex, section: 0), animated: false, scrollPosition: .top)
        }
    }
    
    //MARK:- UI
    fileprivate func setupView() {
        var rect = view.bounds
        rect.origin.y = 64
        rect.size.width = 100
        rect.size.height = screen_height - 64 - 49
        tableView = UITableView.init(frame: rect, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        
        rect.origin.x = 100
        rect.size.width = screen_width - 100
        
        let layout = UICollectionViewFlowLayout()

        col = UICollectionView.init(frame: rect, collectionViewLayout: layout)
        col.delegate = self
        col.dataSource = self
        col.backgroundColor = UIColor.white
        col.isScrollEnabled = true

        view.addSubview(col)
    
        col.register(UINib.init(nibName: "CityCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cityCell")
        col.register(UINib.init(nibName: "OtherCityCell", bundle: Bundle.main), forCellWithReuseIdentifier: "otherCityCell")
        col.register(UINib.init(nibName: "CityInfoFooterView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "cityInfoFooterView")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SQTweetsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            let backView = UIView.init(frame: (cell?.bounds)!)
            backView.backgroundColor = UIColor.white
            cell?.selectedBackgroundView = backView
            cell?.backgroundColor = UIColor.init(hex6: 0xE6E6E6)
            cell?.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        
        let model = modelArr[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.textLabel?.textAlignment = .center
        cell?.textLabel?.text = model.tagname
        return cell!
    }
}

extension SQTweetsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectIndex = indexPath.row
    }

}

extension SQTweetsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = WebViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        print(indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: screen_width - 100, height: 40)
        }
        return CGSize(width: screen_width - 100, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: (screen_width - 130) / 2.0, height: 80)
        } else {
            return CGSize(width: (screen_width - 130) / 2.0, height: 50)
        }
    }

}

extension SQTweetsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !modelArr.isEmpty else {
            return 0
        }
        if section == 1 {
            return (modelArr[selectIndex].tagdata?.countrylist?.count)!
        }
        return (modelArr[selectIndex].tagdata?.citylist?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cityCell", for: indexPath) as! CityCell
            let place_model = modelArr[selectIndex]
            let city_model = place_model.tagdata?.citylist?[indexPath.item]
            cell.setData(model: city_model)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "otherCityCell", for: indexPath) as! OtherCityCell
            let place_model = modelArr[selectIndex]
            let city_model = place_model.tagdata?.countrylist?[indexPath.item]
            cell.setData(model: city_model)
            return cell
        }
      
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "cityInfoFooterView", for: indexPath) as! CityInfoFooterView
        footer.isHidden = false
        if indexPath.section != 0 || (modelArr[selectIndex].tagdata?.countrylist?.isEmpty)! {
            footer.isHidden = true
        } else {
            footer.title.text = modelArr[selectIndex].tagname
            footer.count.text = "\((modelArr[selectIndex].tagdata?.countrylist?.count)!)" + "个国家"
        }
        return footer
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if !(modelArr[selectIndex].tagdata?.countrylist?.isEmpty)! {
            return 2
        }
        return 1
    }
}
