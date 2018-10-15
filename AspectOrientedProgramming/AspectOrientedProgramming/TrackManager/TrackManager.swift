//
//  TrackManager.swift
//  AspectOrientedProgramming
//
//  Created by biesx on 2018/7/5.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit
import Aspects

//swiftlint:disable identifier_name
// MARK: - hook 埋点方法
extension NSObject {
    // create a static method to get a swift class for a string name
    class func swiftClassFromString(_ className: String) -> AnyClass? {
        if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? NSString {
            let fAppName = appName.replacingOccurrences(of: " ", with: "_", options: NSString.CompareOptions.literal, range: NSRange.init())
            return NSClassFromString("\(fAppName).\(className)")
        }
        return nil
    }
}

class TrackManager: NSObject {
    static func setUp() {
        TrackList.trackList().enumerated().forEach { (_, trackM: Track) in
            if let classObj = swiftClassFromString(trackM.className) {
                let selector = NSSelectorFromString(trackM.functionName)
                switch trackM.functionType {
                case .click:
                    trackClick(classObj, selector, trackM.functionName, trackM.trackName, trackM.trackParam)
                case .tableSelect:
                    trackTableSelect(classObj, selector, trackM.functionName, trackM.trackName, trackM.trackParam)
                case .lifeCycle:
                    trackLifeCycle(classObj, selector, trackM.functionName, trackM.trackName, trackM.trackParam)
                case .other :
                    trackOther(classObj, selector, trackM.functionName, trackM.trackName, trackM.trackParam)
                }
            }
        }
    }

    // MARK: - track 分流 buttonClick
    static func trackClick(_ target: AnyClass, _ selector: Selector, _ funcName: String, _ trackId: String, _ trackParam: String) {
        let paramCount = funcName.components(separatedBy: CharacterSet.init(charactersIn: ":")).count - 1
        var wrappedObject: AnyObject
        if paramCount == 0 {
            let wrappedBlock:@convention(block) (AspectInfo) -> Void = { (aspectInfo) in
                ActionReportManager.trackClickRepuest(target, funcName, nil, trackId, trackParam)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        } else {
            let wrappedBlock:@convention(block) (AspectInfo, AnyObject) -> Void = { (aspectInfo, p1) in
                ActionReportManager.trackClickRepuest(target, funcName, p1 as? UIButton, trackId, trackParam)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        }
        do {
            try _ = target.aspect_hook(selector, with: AspectOptions.init(rawValue: 0), usingBlock: wrappedObject)
        } catch {
            print(error)
        }
    }

    // MARK: - track 分流 tableSelect
    static func trackTableSelect(_ target: AnyClass, _ selector: Selector, _ funcName: String, _ trackId: String, _ trackParam: String) {
        let wrappedBlock:@convention(block) (AspectInfo, AnyObject, AnyObject) -> Void = { (aspectInfo, p1, p2) in
            if let table = p1 as? UITableView, let index = p2 as? NSIndexPath {
                ActionReportManager.trackTableSelectRepuest(target, table, index, trackId, trackParam)
            }
        }
        let wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        do {
            try _ = target.aspect_hook(selector, with: AspectOptions.init(rawValue: 0), usingBlock: wrappedObject)
        } catch {
            print(error)
        }
    }

    // MARK: - track 分流 lifeCycle
    static func trackLifeCycle(_ target: AnyClass, _ selector: Selector, _ funcName: String, _ trackId: String, _ trackParam: String) {
        let paramCount = funcName.components(separatedBy: CharacterSet.init(charactersIn: ":")).count - 1
        var wrappedObject: AnyObject
        if paramCount == 0 {
            let wrappedBlock:@convention(block) (AspectInfo) -> Void = { (aspectInfo) in
                ActionReportManager.trackLifeCycleRepuest(target, funcName, trackId, trackParam)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        } else {
            let wrappedBlock:@convention(block) (AspectInfo, Int) -> Void = { (aspectInfo, p1) in
                ActionReportManager.trackLifeCycleRepuest(target, funcName, trackId, trackParam)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        }
        do {
            try _ = target.aspect_hook(selector, with: AspectOptions.init(rawValue: 0), usingBlock: wrappedObject)
        } catch {
            print(error)
        }
    }

    // MARK: - track 分流 other
    static func trackOther(_ target: AnyClass, _ selector: Selector, _ funcName: String, _ trackId: String, _ trackParam: String) {
        let paramCount = funcName.components(separatedBy: CharacterSet.init(charactersIn: ":")).count - 1
        var wrappedObject: AnyObject
        switch paramCount {
        case 0:
            let wrappedBlock:@convention(block) (AspectInfo) -> Void = { (aspectInfo) in
                ActionReportManager.trackOther(target, funcName, trackId, trackParam)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        case 1:
            let wrappedBlock:@convention(block) (AspectInfo, AnyObject) -> Void = { (aspectInfo, p1) in
                ActionReportManager.trackOther(target, funcName, trackId, trackParam, p1)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        case 2:
            let wrappedBlock:@convention(block) (AspectInfo, AnyObject, AnyObject) -> Void = { (aspectInfo, p1, p2) in
                ActionReportManager.trackOther(target, funcName, trackId, trackParam, p1, p2)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        case 3:
            let wrappedBlock:@convention(block) (AspectInfo, AnyObject, AnyObject, AnyObject) -> Void = { (aspectInfo, p1, p2, p3) in
                ActionReportManager.trackOther(target, funcName, trackId, trackParam, p1, p2, p3)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        case 4:
            let wrappedBlock:@convention(block) (AspectInfo, AnyObject, AnyObject, AnyObject, AnyObject) -> Void = { (aspectInfo, p1, p2, p3, p4) in
                ActionReportManager.trackOther(target, funcName, trackId, trackParam, p1, p2, p3, p4)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        default:
            print("warning⚠️： 方法参数过多")
            let wrappedBlock:@convention(block) (AspectInfo) -> Void = { (aspectInfo) in
                ActionReportManager.trackOther(target, funcName, trackId, trackParam)
            }
            wrappedObject = unsafeBitCast(wrappedBlock, to: AnyObject.self)
        }
        do {
            try _ = target.aspect_hook(selector, with: AspectOptions.init(rawValue: 0), usingBlock: wrappedObject)
        } catch {
            print(error)
        }
    }
}

// MARK: - 埋点的data
// ⚠️可以获取函数参数类型如下: id,SEL,int
// ⚠️other必须是OC调用的才可以hook（例如使用#selector+@objc）
// ⚠️相同名字的方法只能hook一次（例如viewDidLoad）
enum FunctionType: String {
    case click
    case tableSelect
    case lifeCycle
    case other
}

struct Track {
    var className = ""
    var functionType = FunctionType.click
    var functionName = ""
    var trackName = ""
    var trackParam = ""
}

class TrackList: NSObject {
    static func trackList() -> [Track] {
        if let fliePath: String = Bundle.main.path(forResource: "trackList.csv", ofType: nil) {
            do {
                let string = try String.init(contentsOfFile: fliePath, encoding: .utf8)
                let arr = string.components(separatedBy: "\n")
                var result = [Track]()
                arr.enumerated().forEach { (_, string) in
                    var item = string
                    if item.contains("\r") {
                        item.removeLast()
                    }
                    if item.count > 6 {
                        let cells = item.components(separatedBy: CharacterSet.init(charactersIn: ","))
                        var trackM = Track()
                        trackM.className = cells[0]
                        if let type = FunctionType.init(rawValue: cells[1]) {
                            trackM.functionType = type
                        }
                        trackM.functionName = cells[2]
                        trackM.trackName = cells[3]
                        trackM.trackParam = cells[4]
                        result.append(trackM)
                    }
                }
                return result
            } catch {

            }
        }
        return []
    }
}
