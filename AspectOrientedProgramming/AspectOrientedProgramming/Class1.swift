//
//  Class1.swift
//  AspectOrientedProgramming
//
//  Created by biesx on 2018/7/4.
//  Copyright © 2018年 biesx. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    static func swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector) {

        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod,
                                           swizzledMethod)
        }
    }
}

extension UIApplication {
    private static let classSwizzedMethod: Void = {
        UINavigationController.sx_initialize
        if #available(iOS 11.0, *) {
            UINavigationBar.sx_initialize
        }
    }()

    open override var next: UIResponder? {
        UIApplication.classSwizzedMethod
        return super.next
    }
}

//extension UIApplication {
//    private static let classSwizzedMethod2: Void = {
//        UINavigationController.sx_initialize
//    }()
//    
//    open override var next2: UIResponder? {
//        UIApplication.classSwizzedMethod
//        return super.next2
//    }
//}
//
//
//
//
//
//extension UITableViewDelegate {
//    
//    
//}
//
//extension UITableView {
//    
//    
//    static let sx_initialize: Void = {
//        DispatchQueue.once(UUID().uuidString) {
//            
//            swizzleMethod(UINavigationController.self,
//                          originalSelector: #selector(UINavigationController.viewDidLoad),
//                          swizzleSelector: #selector(UINavigationController.sx_viewDidLoad))
//            
//            swizzleMethod(UINavigationController.self,
//                          originalSelector: #selector(UINavigationController.viewWillAppear(_:)),
//                          swizzleSelector: #selector(UINavigationController.sx_viewWillAppear(_:)))
//            
//            swizzleMethod(UINavigationController.self,
//                          originalSelector: #selector(UINavigationController.viewWillDisappear(_:)),
//                          swizzleSelector: #selector(UINavigationController.sx_viewWillDisappear(_:)))
//            
//        }
//    }()
//    
//}

//swiftlint:disable identifier_name
public var sx_defultFixSpace: CGFloat = 0
public var sx_disableFixSpace: Bool = false

extension UINavigationController {

    private struct AssociatedKeys {
        static var tempDisableFixSpace = "tempDisableFixSpace"
        static var tempBehavor = "tempBehavor"
    }

    static let sx_initialize: Void = {
        DispatchQueue.once(UUID().uuidString) {

            swizzleMethod(UINavigationController.self,
                          originalSelector: #selector(UINavigationController.viewDidLoad),
                          swizzleSelector: #selector(UINavigationController.sx_viewDidLoad))

            swizzleMethod(UINavigationController.self,
                          originalSelector: #selector(UINavigationController.viewWillAppear(_:)),
                          swizzleSelector: #selector(UINavigationController.sx_viewWillAppear(_:)))

            swizzleMethod(UINavigationController.self,
                          originalSelector: #selector(UINavigationController.viewWillDisappear(_:)),
                          swizzleSelector: #selector(UINavigationController.sx_viewWillDisappear(_:)))

        }
    }()

    private var tempDisableFixSpace: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tempDisableFixSpace) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tempDisableFixSpace, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @available(iOS 11.0, *)
    private var tempBehavor: UIScrollViewContentInsetAdjustmentBehavior {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tempBehavor) as? UIScrollViewContentInsetAdjustmentBehavior ?? .automatic
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tempBehavor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc private func sx_viewDidLoad() {
        disableFixSpace(true, with: true)
        sx_viewDidLoad()
    }

    @objc private func sx_viewWillAppear(_ animated: Bool) {
        disableFixSpace(true, with: false)
        sx_viewWillAppear(animated)
    }

    @objc private func sx_viewWillDisappear(_ animated: Bool) {
        disableFixSpace(false, with: true)
        sx_viewWillDisappear(animated)
    }

    private func disableFixSpace(_ disable: Bool, with temp: Bool) {
        if type(of: self) == UIImagePickerController.self {
            if disable == true {
                if temp { tempDisableFixSpace = sx_disableFixSpace }
                sx_disableFixSpace = true
                if #available(iOS 11.0, *) {
                    tempBehavor = UIScrollView.appearance().contentInsetAdjustmentBehavior
                    UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
                }
            } else {
                sx_disableFixSpace = tempDisableFixSpace
                if #available(iOS 11.0, *) {
                    UIScrollView.appearance().contentInsetAdjustmentBehavior = tempBehavor
                }
            }
        }
    }
}

@available(iOS 11.0, *)
extension UINavigationBar {

    static let sx_initialize: Void = {
        DispatchQueue.once(UUID().uuidString) {
            swizzleMethod(UINavigationBar.self,
                          originalSelector: #selector(UINavigationBar.layoutSubviews),
                          swizzleSelector: #selector(UINavigationBar.sx_layoutSubviews))

        }
    }()

    @objc func sx_layoutSubviews() {
        sx_layoutSubviews()

        if sx_disableFixSpace == false {
            layoutMargins = .zero
            let space = sx_defultFixSpace
            for view in subviews {
                if NSStringFromClass(view.classForCoder).contains("ContentView") {
                    view.layoutMargins = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
                }
            }
        }
    }
}

extension UINavigationItem {

    private enum BarButtonItem: String {
        case left = "_leftBarButtonItem"
        case right = "_rightBarButtonItem"
    }

    open override func setValue(_ value: Any?, forKey key: String) {

        if #available(iOS 11.0, *) {
            super.setValue(value, forKey: key)
        } else {
            if sx_disableFixSpace == false && (key == BarButtonItem.left.rawValue || key == BarButtonItem.right.rawValue) {
                guard let item = value as? UIBarButtonItem else {
                    super.setValue(value, forKey: key)
                    return
                }
                let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                space.width = sx_defultFixSpace - 16

                if key == BarButtonItem.left.rawValue {
                    leftBarButtonItems = [space, item]
                } else {
                    rightBarButtonItems = [space, item]
                }
            } else {
                super.setValue(value, forKey: key)
            }
        }
    }
}

extension DispatchQueue {
    static var `default`: DispatchQueue { return DispatchQueue.global(qos: .`default`) }
    static var userInteractive: DispatchQueue { return DispatchQueue.global(qos: .userInteractive) }
    static var userInitiated: DispatchQueue { return DispatchQueue.global(qos: .userInitiated) }
    static var utility: DispatchQueue { return DispatchQueue.global(qos: .utility) }
    static var background: DispatchQueue { return DispatchQueue.global(qos: .background) }

    func after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }

    private static var _onceTracker = [String]()
    public class func once(_ token: String, block:() -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}
