//
//  SQDiscoverViewController.swift
//  iosapp-swift
//
//  Created by YinSQ on 2017/2/16.
//  Copyright © 2017年 ysq. All rights reserved.
//

import UIKit

class SQDiscoverViewController: UIViewController {

    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        // Do any additional setup after loading the view.
    }
    
    func setupSubviews() {
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.init(hex6: 0xC8C7CC)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SQDiscoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "开源软件"
            cell.imageView?.image = UIImage(named:"ic_discover_softwares")
        case 1:
            cell.textLabel?.text = ["扫一扫","摇一摇"][indexPath.row]
            cell.imageView?.image = UIImage(named:["ic_discover_scan", "ic_discover_shake"][indexPath.row])
        case 2:
            cell.textLabel?.text = "附近的程序员"
            cell.imageView?.image = UIImage(named:"ic_discover_nearby")
        case 3:
            cell.textLabel?.text = "线下活动"
            cell.imageView?.image = UIImage(named:"ic_my_event")
        default: break

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 2, 3:
            return 1
        case 1:
            return 2
        default:
            return 0
       }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 23
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
}

extension SQDiscoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
