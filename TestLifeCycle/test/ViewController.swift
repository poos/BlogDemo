//
//  ViewController.swift
//  test
//
//  Created by biesx on 2018/10/26.
//  Copyright © 2018 biesx. All rights reserved.
//

import UIKit

//[Swift 学习笔记4 —— 文件结构，作用域和生命周期](https://n3xtchen.github.io/n3xtchen/swift/2016/02/14/swift-tut4)

class A: NSObject {
    
    let block: (Bool) -> Void
    
    init(block: @escaping (Bool) -> Void) {
        self.block = block
    }

    deinit {
        print("\(self)A deinit")
    }
    
}

class B: NSObject {
    
    var a = false
    
    var aC: A!
    
    func testBlcok() {
        
        func blockAction(b: B?, isT: Bool) {
            b?.a = isT
        }
        
        aC = A.init(block: { [weak self] (isT) in
            blockAction(b: self, isT: isT)
        })
        aC.block(true)
    }
    
    deinit {
        print("\(self)😆B deinit")
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var b = B()
        b.testBlcok()
        b = B()
        b.testBlcok()
        let c = B()
        c.testBlcok()
        
//        UIView.init(frame: <#T##CGRect#>)
    }


}

