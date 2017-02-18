//
//  SQNewsViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit


class SQNewsViewController: UIViewController {

    var tableView: UITableView?
    lazy var modelArr = [SQNewsModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
        loadData()
        // Do any additional setup after loading the view.
    }

    func loadData() {
        SQNetworkManager.shared.getRequest(urlString: "https://www.oschina.net/action/openapi/news_list?access_token=769bc2f0-ada7-42e6-8d34-036273ad57a7&catalog=1&page=1&pageSize=20&dataType=json", parameters: nil) { (isSuccess, json, error) in
            if isSuccess {
                let dataArr = json?["newslist"]
                for item in dataArr! {
                    let model = SQNewsModel.yy_model(with: item.1.dictionaryObject!)
                    self.modelArr.append(model!)
                }
                self.tableView?.reloadData()
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
        let model = modelArr[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArr.count
    }
}
