//
//  CommunityViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/3.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit
import MJRefresh

class CommunityViewController: SQBaseViewController {

    var page = 1
    
    lazy var communityModelArr = [CommunityModel]()
    
    lazy var recommendModelArr = [RecommendCommunityModel]()
    
    lazy var columnModelArr = [ColumnModel]()
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setRefreshView()
        loadData()
        // Do any additional setup after loading the view.
    }

    override func loadData() {
        super.loadData()
        let urlString = String(format: hot_bbs, page)
        SQNetworkManager.shared.GET(urlString: urlString, parameters: nil) { (isSuccess, json, error) in

            let data = json?["data"]
            let index_list = data?["index_list"]
            if self.page == 1 {
                self.communityModelArr.removeAll()
                self.recommendModelArr.removeAll()
                self.columnModelArr.removeAll()
            }
            for dict in index_list! {
                let model = CommunityModel.yy_model(with: dict.1.dictionaryObject!)
                self.communityModelArr.append(model!)
            }
            
            let tag_list = data?["tag_list"]
            if self.recommendModelArr.isEmpty {
                for dict in tag_list! {
                    let model = RecommendCommunityModel.yy_model(with: dict.1.dictionaryObject!)
                    self.recommendModelArr.append(model!)
                }
            }
            
            let icon_list = data?["icon_list"]
            if self.columnModelArr.isEmpty {
                for dict in icon_list! {
                    let model = ColumnModel.yy_model(with: dict.1.dictionaryObject!)
                    self.columnModelArr.append(model!)
                }
            }
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    fileprivate func setupSubviews() {
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.register(CommunityCell.self, forCellReuseIdentifier: "cell")
    }
    
    fileprivate func setRefreshView() {
        let footer = MJRefreshAutoNormalFooter.init { 
            [unowned self] in
            self.page += 1
            self.loadData()
        }
        footer?.isAutomaticallyRefresh = true
        footer?.isAutomaticallyHidden = true
        tableView.mj_footer = footer
        
        let header = MJRefreshNormalHeader.init { 
            [unowned self] in
            self.page = 1
            self.loadData()
        }
        tableView.mj_header = header
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CommunityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityModelArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommunityCell
        let model = communityModelArr[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("CommunityHeaderView", owner: nil, options: nil)?.last as! CommunityHeaderView
        view.recommend_modelArr = recommendModelArr
        view.column_modelArr = columnModelArr
        return view
    }
    
}

extension CommunityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = communityModelArr[indexPath.row]
        guard !(model.bigpic_arr?.isEmpty)! else {
            return 120
        }
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}
