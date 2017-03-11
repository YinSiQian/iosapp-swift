//
//  BBSLayoutViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/3/3.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class BBSLayoutViewController: SQBaseViewController {

    lazy var modelArr = [BBSModel]()
    
    var listTableView: UITableView!
    
    var contentTableView: UITableView!

    var selectedIndex = 0 {
        didSet {
            self.contentTableView.reloadData()
        }
    }
    //MARK: -view cycle life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        loadData()
    }

    //MARK: - load Data
    
    override func loadData() {
        super.loadData()
        SQNetworkManager.shared.GET(urlString: bbs_list, parameters: nil ){
            (isSuccess, json, error) in
            
            if isSuccess {
                let data = json?["data"]
                let arr = data?["forum_list"]
                for dict in arr! {
                    let model = BBSModel.yy_model(with: dict.1.dictionaryObject!)
                    self.modelArr.append(model!)
                }
                self.setupSubviews()
            }
        }
    }
    
    private func setupSubviews() {
        var rect = self.view.bounds
        rect.size.width = 100
        rect.size.height = screen_height - 64 - 49
        listTableView = UITableView(frame: rect, style: .plain)
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.tableFooterView = UIView()
        listTableView.backgroundColor = UIColor.init(hex6: 0xE6E6E6)
        
        view.addSubview(listTableView)
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "list")
        listTableView.selectRow(at: IndexPath.init(row: selectedIndex, section: 0), animated: false, scrollPosition: .top)
        
        
        rect.size.width = screen_width - 100
        rect.origin.x = 100
        contentTableView = UITableView(frame: rect, style: .plain)
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.tableFooterView = UIView()

        view.addSubview(contentTableView)
        contentTableView.register(DestinationInfoView.self, forCellReuseIdentifier: "content")

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension BBSLayoutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == listTableView {
            return modelArr.count
        }
        return (modelArr[selectedIndex].group?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "list", for: indexPath)
            let backView = UIView.init(frame: cell.bounds)
            backView.backgroundColor = UIColor.white
            cell.selectedBackgroundView = backView
            cell.backgroundColor = UIColor.init(hex6: 0xE6E6E6)
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = modelArr[indexPath.row].name
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "content", for: indexPath) as! DestinationInfoView
        let model = modelArr[selectedIndex].group?[indexPath.row]
        cell.model = model
        return cell
    }
}

extension BBSLayoutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == listTableView {
            selectedIndex = indexPath.row
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == listTableView {
            return 60
        }
        return 70
    }
}

