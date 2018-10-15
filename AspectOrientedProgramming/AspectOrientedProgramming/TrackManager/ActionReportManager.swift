//
//  ActionReportManager.swift
//  AspectOrientedProgramming
//
//  Created by biesx on 2018/7/5.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit

class ActionReportManager: NSObject {
    static func trackClickRepuest(_ target: AnyClass, _ funcName: String, _ button: UIButton?, _ trackId: String, _ trackParam: String) {
        if let but = button {
            print("Click-\(target)->\(funcName)->\(but)->\(trackId)->\(trackParam)")
        } else {
            print("Click-\(target)->\(funcName)->\(trackId)->\(trackParam)")
        }

    }

    static func trackTableSelectRepuest(_ target: AnyClass, _ table: UITableView, _ index: NSIndexPath, _ trackId: String, _ trackParam: String) {
        print("TableSelect-\(target)->\(table)->\(index)->\(trackId)->\(trackParam)")
    }

    static func trackLifeCycleRepuest(_ target: AnyClass, _ funcName: String, _ trackId: String, _ trackParam: String) {
        print("LifeCycle-\(target)->\(funcName)->\(trackId)->\(trackParam)")
    }

    static func trackOther(_ target: AnyClass, _ funcName: String, _ trackId: String, _ trackParam: String, _ param: AnyObject...) {
        print("Other-\(target)->\(funcName)->\(trackId)->\(trackParam)--p-->\(param)")
    }
}
