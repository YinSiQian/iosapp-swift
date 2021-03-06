//
//  SQNewsViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit
import MJRefresh

class SQNewsViewController: SQBaseViewController {

    var tableView: UITableView!
    var nearModel: NearRecommendModel?
    var recommendModel: RecommendModel?
    var page = 1
    
    var locationManager: AMapLocationManager!
    var search: AMapSearchAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
        setRefreshView()
        loadData()
        loadRecommendData()
        //mapConfig()
    }

    
    fileprivate func mapConfig() {
        locationManager = AMapLocationManager()
        locationManager.delegate = self as AMapLocationManagerDelegate
        
        search = AMapSearchAPI()
        search.delegate = self as AMapSearchDelegate
        
        locationManager.pausesLocationUpdatesAutomatically = false
        if #available(iOS 9.0, *) {
            locationManager.allowsBackgroundLocationUpdates = true
        }
        locationManager.locatingWithReGeocode = true
        locationManager.startUpdatingLocation()
    }
    
    override func loadData() {
        SQNetworkManager.shared.GET(urlString: home_city_info, parameters: nil) { [weak self] (isSuccess, json, error) in
            if isSuccess {
                let data = json?["data"]
                self?.nearModel = NearRecommendModel.yy_model(with: (data?.dictionaryObject!)!)
                self?.tableView.reloadData()
            }
        }
    }
    
    func loadRecommendData() {
        let urlString = String(format: home_feed, page)
        SQNetworkManager.shared.GET(urlString: urlString, parameters: nil) {
           [weak self]  (success, json, error) in
            if success {
                let data = json?["data"]
                if self?.page == 1 {
                    self?.recommendModel = RecommendModel.yy_model(with: (data?.dictionaryObject)!)
                    self?.setHeaderViewData()
                } else {
                    let model = RecommendModel.yy_model(with: (data?.dictionaryObject)!)
                    for item in (model?.feed?.entry!)! {
                        self?.recommendModel?.feed?.entry?.append(item)
                    }
                    self?.tableView.mj_footer.endRefreshing()
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func setHeaderViewData() {
        let headerView = tableView?.tableHeaderView as! RecommendHeaderView
        headerView.setData(modelArr: (recommendModel?.slide)!)
        tableView.reloadData()
    }
    
    func setRefreshView() {
        let footer = MJRefreshAutoNormalFooter.init {
            [weak self] in
            self?.page += 1
            self?.loadRecommendData()
        }
        tableView.mj_footer = footer
        footer?.isAutomaticallyHidden = true
        footer?.isAutomaticallyRefresh = true
    }
    
    func layoutSubviews() {
        tableView = UITableView.init(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.register(UINib.init(nibName: "NearlyCityCell", bundle: Bundle.main), forCellReuseIdentifier: "nearlyCityCell")
        tableView.register(UINib.init(nibName: "RecommendCell", bundle: Bundle.main), forCellReuseIdentifier: "recommendCell")
        
        let headerView = RecommendHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: 200)) {
            [weak self]
            (index)  in
            let vc = WebViewController()
            let model = self?.recommendModel?.slide?[index]
            vc.urlString = model?.url
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.tableHeaderView = headerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SQNewsViewController: AMapSearchDelegate {
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        if response.regeocode == nil {
            return
        }
        print(response.regeocode.formattedAddress)
    }
}

extension SQNewsViewController: AMapLocationManagerDelegate {
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let regeo = AMapReGeocodeSearchRequest()
        regeo.location = AMapGeoPoint.location(withLatitude: CGFloat(lat), longitude: CGFloat(lon))
        regeo.requireExtension = true
        search.aMapReGoecodeSearch(regeo)
    }
    
}

extension SQNewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard indexPath.section != 0 else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        let webVC = WebViewController()
        let model = recommendModel?.feed?.entry?[indexPath.section - 1]
        webVC.urlString = model?.url
        navigationController?.pushViewController(webVC, animated: true)
    }
}

extension SQNewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nearlyCityCell", for: indexPath)
                as! NearlyCityCell
            if nearModel != nil {
                cell.setData(model: nearModel!)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recommendCell", for:
             indexPath) as! RecommendCell
            let model = recommendModel?.feed?.entry?[indexPath.section - 1]
            cell.setData(model: model!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 1 {
            return 0.1
        }
        return 15.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard recommendModel != nil else {
            return 1
        }
        return 1 + (recommendModel?.feed?.entry?.count)!
    }
}
