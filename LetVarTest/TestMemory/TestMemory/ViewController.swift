//
//  ViewController.swift
//  TestMemory
//
//  Created by biesx on 2018/12/14.
//  Copyright © 2018 biesx. All rights reserved.
//

import UIKit

func stringClassFromString(_ className: String) -> AnyClass! {
    
    /// get namespace
    let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
    
    /// get 'anyClass' with classname and namespace
    let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!;
    
    // return AnyClass!
    return cls;
}

class ViewController: UIViewController {
    enum Title: String {
        case properties = "计算属性Computed Properties"
        
        static let dic: [Title: String] = [.properties: "ComputedPropertiesViewController"]
        
        var vc: UIViewController? {
            guard let VC = stringClassFromString(ViewController.Title.dic[self]!) as! UIViewController.Type? else {
                return nil
            }
            return VC.init()
        }
    }
    
    
    
    
    let table = UITableView.init(frame: UIScreen.main.bounds)
    
    let data: [Title] = [.properties]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = data[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = data[indexPath.row].vc else {
            return
        }
        vc.view.backgroundColor = .white
        let nav = NavigationController.init(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
}


class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            let top = self.topViewController
            let barButton = UIBarButtonItem.init(title: "dismiss", style: .plain, target: self, action: #selector(self.dismissNav))
            top?.navigationItem.rightBarButtonItem = barButton
        }
    }
    
    @objc func dismissNav() {
        self.dismiss(animated: true, completion: nil)
    }
}
