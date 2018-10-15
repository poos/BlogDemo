//
//  TargetA.swift
//  testCTMdeiator
//
//  Created by biesx on 2018/6/19.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit

enum CMTDictionaryKeys: String {
    case id
    case callback
}
typealias CallbackType = (NSString) -> Void



//创建了一个中间类Target_VCA，通过中间类调用 A 组件

/// @objc 对 OC 开放，然后就可以使用 OC 的 target-action 来runtime 调用
@objc(Target_VCA)
class Target_VCA: NSObject {
    
    @objc
    func Action_viewControllerA(params:NSDictionary) -> UIViewController {
        if let param: [CMTDictionaryKeys: Any] = params as? [CMTDictionaryKeys : Any] {
            
            let block = param[.callback]
            let call = block as? CallbackType
            call!("success")
        }
        
        let aViewController = ViewControllerA()
        return aViewController
    }
    
}

