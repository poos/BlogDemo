//
//  TableViewController.swift
//  AspectOrientedProgramming
//
//  Created by biesx on 2018/7/4.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        let button2 = UIButton.init(frame: CGRect.init(x: 100, y: 300, width: 100, height: 100))
        self.view.addSubview(button2)
        button2.setTitle("button2", for: .normal)
        button2.backgroundColor = UIColor.lightGray
        button2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)


        tableView.reloadData()
    }

    @objc func buttonAction() {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "a    ->" + "\(indexPath)"
        cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.lightGray : UIColor.gray
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
