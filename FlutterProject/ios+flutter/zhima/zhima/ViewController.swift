//
//  ViewController.swift
//  zhima
//
//  Created by biesx on 2019/4/28.
//  Copyright © 2019 biesx. All rights reserved.
//

import UIKit
import Flutter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 100, width: 100, height: 100))
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(handleButtonAction), for: .touchUpInside)
        view.addSubview(button)
        
    }

    @objc func handleButtonAction() {
        
//        let flutterEngine = (UIApplication.shared.delegate as? AppDelegate)?.flutterEngine;
//        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)!;
        
        
        let flutterViewController = FlutterViewController.init();
        flutterViewController.setInitialRoute("route1")
        
//        self.present(flutterViewController, animated: false, completion: nil)
        
        guard let view = flutterViewController.view else {
            return
        }
        view.frame = CGRect.init(x: 0, y: 200, width: 414, height: 500)
        self.view?.addSubview(view)
        
    }
}

