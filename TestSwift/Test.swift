//
//  ViewController.swift
//  test
//
//  Created by biesx on 2018/10/26.
//  Copyright © 2018 biesx. All rights reserved.
//

import Foundation

class A: NSObject {
    
    let block: (Bool) -> Void
    
    init(block: @escaping (Bool) -> Void) {
        self.block = block
    }
    
    func use() {
        block(false)
    }
    
    deinit {
        print("\(self)A deinit")
    }
    
}

class B: NSObject {
    
    //    let block: () -> Void
    
    var a = false
    //
    //    init(block: @escaping () -> Void) {
    //        self.block = block
    //    }
    var aC = A.init { (_) in
        
    }
    
    func testBlcok() {
        
//        func blockAction(isT: Bool) {
//            a = isT
////            print("hahhah\(isT)")
//        }
        
        aC = A.init(block: { [weak self] (isT) in
            self?.a = isT
        })
        
        
        aC.block(true)
//        aC.block(false)
        //        print(Unmanaged.passRetained(aC))
//        print(aC)
    }
    
    deinit {
        
        print("\(self)😆B deinit")
    }
}

        var b = B()
        b.testBlcok()
//        b.testBlcok()
//        print("---")
        let c = B()
        c.testBlcok()
////        c.testBlcok()
////        print("---")
        b = c
//        b.testBlcok()
//        b.testBlcok()
//        b = nil

