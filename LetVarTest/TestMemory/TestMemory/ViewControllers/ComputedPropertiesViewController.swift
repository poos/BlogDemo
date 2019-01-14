//
//  ComputedPropertiesViewController.swift
//  TestMemory
//
//  Created by biesx on 2018/12/14.
//  Copyright © 2018 biesx. All rights reserved.
//

import UIKit

class A {
    let a = "a"
    
    var attS: NSAttributedString
    
    init() {
        let att = NSMutableAttributedString.init(string: "a")
        att.append(att)
        att.insert(att, at: 0)
        att.append(att)
        attS = att
    }
}

class B {
    let b = "b"
    
    var attS: NSAttributedString {
        let att = NSMutableAttributedString.init(string: "a")
        att.append(att)
        att.insert(att, at: 0)
        let append = NSAttributedString.init(string: self.b)
        att.append(append)
        return att
    }
}

class ComputedPropertiesViewController: BaseViewController {
    
    var classAs = [A]()
    
    var classBs = [B]()
    
    var attS = [NSAttributedString]()
    
    var isA = true

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.backgroundColor = UIColor.lightGray
        view.addSubview(button)
        
        
        // Do any additional setup after loading the view.
        
        buttonAction()
    }
    
    @objc func buttonAction() {
        isA.toggle()
        let str = "isA(存储变量)---> \(isA)"
        label.text = str
    }
    
    override func tapAction() {
        
        let date = Date().timeIntervalSince1970
        for _ in 0 ... 10000 {
            if isA {
                let a = A()
                
                attS.append(a.attS)
                attS.append(a.attS)
                attS.append(a.attS)
                attS.append(a.attS)
                attS.append(a.attS)
                attS.append(a.attS)
                
                classAs.append(a)
                
                
            } else {
                let b = B()
                
                attS.append(b.attS)
                attS.append(b.attS)
                attS.append(b.attS)
                attS.append(b.attS)
                attS.append(b.attS)
                attS.append(b.attS)
                
                classBs.append(b)
            }
        }
        
        let date1 = Date().timeIntervalSince1970
        
        
        
        num += 1
        let str = "end---> \(num)-----\(date1 - date)"
        label.text = str
        
        print(str)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
