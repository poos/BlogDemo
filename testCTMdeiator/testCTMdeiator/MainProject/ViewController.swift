//
//  ViewController.swift
//  testCTMdeiator
//
//  Created by biesx on 2018/6/19.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit
import CTMediator

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = UIColor.lightGray
        button.setTitle("调用组件", for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(ViewController.buttonAction), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
        let label = UILabel.init(frame: self.view.bounds)
        label.text = "🐂我是主工程"
        self.view.addSubview(label)
    }

    @objc func buttonAction() {
        NSLog("🐂我是主工程，将调用组件A")
        
        let acontroller = CTMediator.sharedInstance().viewControllerA { result in
            NSLog("result is -> \(result)")
        }
        
        let avc = CTMediator.shared.viewControllerA()
        self.present(acontroller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

