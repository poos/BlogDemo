import UIKit
import Foundation
import PlaygroundSupport
// 在iOS和tvOS，实时取景是基于UIView或UIViewController，并在Mac OS是基于NSView或NSViewController
let vc = UINavigationController.init()
vc.view.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = vc


let label = UILabel.init(frame: CGRect.init(x: 100, y: 100, width: 300, height: 100))
label.backgroundColor = UIColor.lightGray
vc.view.addSubview(label)


func mutableAttS(_ string: String) -> NSMutableAttributedString {
    return NSMutableAttributedString.init(string: string)
}

let attS = mutableAttS("i am title")

//---------------------------------------------------------
// 实现各个函数

typealias MutableAttributeFunc = (NSMutableAttributedString) -> NSMutableAttributedString

func font(_ font: UIFont) -> MutableAttributeFunc {
    return { attString in
        attString.addAttribute(.font, value: font, range: NSRange.init(location: 0, length: attString.length))
        return attString
    }
}

func color(_ color: UIColor) -> MutableAttributeFunc {
    return { attString in
        attString.addAttribute(.foregroundColor, value: color, range: NSRange.init(location: 0, length: attString.length))
        return attString
    }
}

func alignment(_ align: NSTextAlignment) -> MutableAttributeFunc {
    return { attString in
        print("🖲 is nil = \(attString.attribute(.paragraphStyle, at: 0, effectiveRange: nil) == nil))")
        let paragraphStyle = attString.attribute(.paragraphStyle, at: 0, effectiveRange: nil) ?? NSMutableParagraphStyle()
        (paragraphStyle as! NSMutableParagraphStyle).alignment = align
        attString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attString.length))
        return attString
    }
}

//直接调用版本
//let fontOne = font(.boldSystemFont(ofSize: 14))
//let colorOne = color(.black)
//
//let title = color(.black)(font(.boldSystemFont(ofSize: 14))(attS))




//---------------------------------------------------------
// 拼接函数


//拼接函数版本
//func composeFilters(_ filter1: @escaping MutableAttributeFunc, _ filter2: @escaping MutableAttributeFunc) -> MutableAttributeFunc {
//    return { attString in filter2(filter1(attString)) }
//}

//调用
//let fontAndColor = composeFilters(color(.black), font(.boldSystemFont(ofSize: 14)))


//---------------------------------------------------------
// 符号化支持


precedencegroup ATPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

infix operator >>> : ATPrecedence

// 旧的拼接函数
//func >>>(filter1: @escaping MutableAttributeFunc, filter2: @escaping MutableAttributeFunc) -> MutableAttributeFunc {
//    return { attString in filter2(filter1(attString)) }
//}

func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { x in g(f(x)) }
}



//---------------------------------------------------------
//  最终调用

let titleOneF = font(.systemFont(ofSize: 13)) >>> color(.red) >>> color(.black) >>> color(.blue) >>> alignment(.center) >>> alignment(.center)

let titleTwoF = titleOneF >>> color(.blue)

//titleOneF(attS)
//titleTwoF(string("hashdfhahf"))

//label.attributedText = attS
label.attributedText = titleTwoF(attS)






// bones
func add2(_ x: Int) -> (Int) -> Int {
    return { y in return x + y }
}

add2(1)(2)


