//
//  ViewController.swift
//  RxSwiftLeaks
//
//  Created by biesx on 2018/12/5.
//  Copyright © 2018 biesx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(check))
        view.addGestureRecognizer(tap)
    }
    
    @objc func check() {
        let testVc = TestController()
        testVc.reactor = TextReactor()
        let nav = NavigationController.init(rootViewController: testVc)
        
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

