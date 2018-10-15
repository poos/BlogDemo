//
//  TestViewController.swift
//  testCTMdeiator
//
//  Created by biesx on 2018/6/19.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit

class ViewControllerB: UIViewController {
    let vc = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init(frame: self.view.bounds)
        label.text = "🐂我是主工程中，复杂的一个页面B😂，太过复杂，暂时不敢组件化，点击dismiss"
        label.numberOfLines = 0
        self.view.addSubview(label)
self.title = "test"
        self.view.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view.
   
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
    
        let button = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = UIColor.gray
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(ViewController.buttonAction), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func buttonAction() {
        NSLog("UIViewController go")
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction2))
        vc.view.addGestureRecognizer(tap)
        vc.view.backgroundColor = UIColor.white
        let label = UILabel.init(frame: self.view.bounds)
        label.text = "🐂我是主工程中，某个页面😂，点击dismiss"
        label.numberOfLines = 0
        vc.view.addSubview(label)
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func tapAction() {
        self.dismiss(animated: true, completion: nil)
        NSLog(" TestViewController  dismiss")
    }
    
    @objc func tapAction2() {
        NSLog("UIViewController dissmiss")
        vc.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
