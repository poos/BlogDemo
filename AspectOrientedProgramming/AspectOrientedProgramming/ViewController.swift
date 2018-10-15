//
//  ViewController.swift
//  AspectOrientedProgramming
//
//  Created by biesx on 2018/7/3.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.title = "title"

        let button = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        self.view.addSubview(button)
        button.setTitle("button", for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.

        let button2 = UIButton.init(frame: CGRect.init(x: 100, y: 300, width: 100, height: 100))
        self.view.addSubview(button2)
        button2.setTitle("button2", for: .normal)
        button2.backgroundColor = UIColor.lightGray
        button2.addTarget(self, action: #selector(buttonActionNext(_:)), for: .touchUpInside)
    }

    @objc func buttonAction() {

        let select =  #selector(buttonActionNext2(_:))

        let random = arc4random() % 5
        self.performSelector(inBackground: select, with: "\(random)")
    }
    @objc func buttonActionNext(_ button: UIButton) {
        let vc = TableViewController()
        self.present(vc, animated: true, completion: nil)
        testAAA()
    }

    @objc func buttonActionNext2(_ next: String) {
        let select =  #selector(checkBool(_:))
        self.performSelector(inBackground: select, with: true)
    }

    @objc func checkBool(_ bool: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Track
protocol TrackProtocol {
//    func clickQuestionCell(_ id: Int)
//    func clickAnswerCell(_ id: Int)
//    func clickSearch()
//    func clickAsk()
//    func inScreen(_ ids: String)
    func testAAA()
}
extension ViewController: TrackProtocol {

}

//extension ViewController: TrackProtocol {
//    func inScreen(_ ids: String) {
//
//    }
//
//    func clickQuestionCell(_ id: Int) {
//        print("---------------sdfasfd")
//    }
//    func clickAnswerCell(_ id: Int) {
//
//    }
//    func clickSearch() {
//
//    }
//    func clickAsk() {
//
//    }
//
//    func testAAA() {
//        print("---------------sdfasfd")
//    }
//
//}
// MARK: - Track
extension TrackProtocol where Self: ViewController {
    func testAAA() {
        print("===============")
        print(self.title)
        print(self)
    }

    func clickQuestionCell(_ id: Int) {
        print("id: Int")
    }
}

extension TrackProtocol where Self: TableViewController {
    func testAAA() {

    }
}
