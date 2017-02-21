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
        // Do any additional setup after loading the view.
    }

    override func loadData() {

        SQNetworkManager.shared.getRequest(urlString: home_city_info, parameters: nil) { (isSuccess, json, error) in
            if isSuccess {
                let data = json?["data"]
                self.nearModel = NearRecommendModel.yy_model(with: (data?.dictionaryObject!)!)
                
            }
        }
    }
    
    func loadRecommendData() {
        SQNetworkManager.shared.getRequest(urlString: home_feed, parameters: nil) { (success, json, error) in
            if success {
                let data = json?["data"]
                self.recommendModel = RecommendModel.yy_model(with: (data?.dictionaryObject)!)
            } 
        }
    }
    
    func layoutSubviews() {
        tableView = UITableView.init(frame: view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
        tableView?.register(UINib.init(nibName: "SQNewsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SQNewsTableViewCell
        //let model = modelArr[indexPath.row]
        //cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
