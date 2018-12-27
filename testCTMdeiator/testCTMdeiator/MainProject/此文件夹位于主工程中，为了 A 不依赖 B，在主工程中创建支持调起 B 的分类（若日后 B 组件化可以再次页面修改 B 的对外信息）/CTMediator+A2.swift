//
//  CTMediator+A2.swift
//  testCTMdeiator
//
//  Created by biesx on 2018/6/19.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit
import CTMediator
//可以考虑每个组件创建一个便利方法，，所有的便利类（s复数）放入主工程，但是是由对应的开发组件的人去维护
//但是注意去除依赖

extension CTMediator {
    static var shared: CTMediator {
        return CTMediator.sharedInstance()!
    }
}

//便利方法
extension CTMediator {
    //便利的取A方法
    typealias CallBackType = (NSString) -> Void
    
    func viewControllerA(callback: @escaping (NSString) -> Void = {_ in }) -> UIViewController {
        var param = [String: Any]()
        param["id"] = 123
        param["callback"] = callback
        return self.performTarget("VCA", action: "viewControllerA", params: param, shouldCacheTarget: false) as? UIViewController ?? UIViewController()
    }
    
    
}




// MARK: - 用到了B在这里取B

//便利方法
extension CTMediator {
    
    //便利的取B方法
    static func viewControllerB(callback: @escaping (NSString) -> Void) -> UIViewController {
        let param = ["callback" : callback]
        return self.shared.performTarget("VCB", action: "viewControllerB", params: param, shouldCacheTarget: false) as! UIViewController
    }
}




//因为B还没有被组件化，所以暂时写一个取B的便利方法！！！！！！！！当B组件化之后应该把这部分去掉
@objc(Target_VCB)
class Target_VCB: NSObject {
    
    /* 此部分要求严格按照这个方式写方法 */
    /// 限定规则
    /// 开放给OC
    /// Action
    ///
    /// - Parameter params: 只能有一个参数且名为params，字典类型
    /// - Returns: 返回VC/View/等组件
    @objc
    func Action_viewControllerB(params:NSDictionary) -> UIViewController {
        let block = params["callback"]
        typealias CallbackType = (NSString) -> Void
        let call = block as? CallbackType
        call!("success")
        
        let aViewController = ViewControllerB()
        return aViewController
    }
    
}
