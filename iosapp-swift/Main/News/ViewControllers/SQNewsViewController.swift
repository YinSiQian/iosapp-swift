//
//  SQNewsViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit


class SQNewsViewController: SQBaseViewController {

    var tableView: UITableView?
    var nearModel: NearRecommendModel?
    var recommendModel: RecommendModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
        loadData()
        loadRecommendData()
    }

    override func loadData() {
        SQNetworkManager.shared.getRequest(urlString: home_city_info, parameters: nil) { (isSuccess, json, error) in
            if isSuccess {
                let data = json?["data"]
                self.nearModel = NearRecommendModel.yy_model(with: (data?.dictionaryObject!)!)
                self.tableView?.reloadData()
            }
        }
    }
    
    func loadRecommendData() {
        SQNetworkManager.shared.getRequest(urlString: home_feed, parameters: nil) { (success, json, error) in
            if success {
                let data = json?["data"]
                self.recommendModel = RecommendModel.yy_model(with: (data?.dictionaryObject)!)
                self.setHeaderViewData()
            } 
        }
    }
    
    func setHeaderViewData() {
        let headerView = tableView?.tableHeaderView as! RecommendHeaderView
        headerView.setData(modelArr: (recommendModel?.slide)!)
        tableView?.reloadData()
    }
    
    func layoutSubviews() {
        tableView = UITableView.init(frame: view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        tableView?.register(UINib.init(nibName: "NearlyCityCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
        let headerView = RecommendHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: 200))
        tableView?.tableHeaderView = headerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SQNewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SQNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! NearlyCityCell
        if nearModel != nil {
            cell.setData(model: nearModel!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 415
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
