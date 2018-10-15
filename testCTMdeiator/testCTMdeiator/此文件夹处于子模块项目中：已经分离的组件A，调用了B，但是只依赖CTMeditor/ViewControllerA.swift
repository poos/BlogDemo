//
//  ViewController1.swift
//  testCTMdeiator
//
//  Created by biesx on 2018/6/19.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit
import CTMediator

class ViewControllerA: UIViewController {
    let vc = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("😄我是组件A，didload")
        let label = UILabel.init(frame: self.view.bounds)
        label.text = "😄我是组件A，VCA，点击内部调用"
        self.view.addSubview(label)
        self.view.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
        setButton()
    }
    
    
    @objc func tapAction() {
        NSLog("😄我是组件A，组件内调用")
        vc.view.backgroundColor = UIColor.white
        let label = UILabel.init(frame: self.view.bounds)
        label.text = "😄我是组件A，VC，点击dismiss"
        vc.view.addSubview(label)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction2))
        vc.view.addGestureRecognizer(tap)
        vc.view.backgroundColor = UIColor.white
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func tapAction2() {
        self.dismiss(animated: true, completion: nil)
        NSLog(" TestViewController  dismiss")
    }
    
    
    
    //--------------------------
    
    /// 外部调用
    @objc func buttonAction() {
//        self.dismiss(animated: true, xcompletion: nil)
        NSLog("😄我是组件A，正在调用主工程或者其他工程的页面")
//        let vcB = TestViewController()
        
        //在分类中添加B的方便调用，修改B模块的调用方式
        let vcB = CTMediator.viewControllerB { result in
            NSLog("result is -> \(result)")
        }
        self.present(vcB, animated: true, completion: nil)
    }
    
    func setButton() {
    
        let button = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 200, height: 100))
        button.backgroundColor = UIColor.gray
        button.setTitle("调用主工程的B部分", for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(ViewControllerA.buttonAction), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
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
