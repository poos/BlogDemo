//
//  ViewController.swift
//  SingleView
//
//  Created by biesx on 2018/11/9.
//  Copyright © 2018 biesx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let lab = UILabel.init(frame: CGRect.init(x: 20, y: 300, width: 345, height: 300))
    
    var cas = [A]()
    
    var cbs = [B]()
    
    var ccs = [C]()
    
    var cds = [D]()
    
    var res = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(releaseArr))
        view.addGestureRecognizer(tap)
        
        let button = UIButton.init(frame: CGRect.init(x: 100, y: 100, width: 500, height: 100))
        button.backgroundColor = UIColor.lightGray
        view.addSubview(button)
        button.addTarget(self, action: #selector(check), for: .touchUpInside)
    }
    
    @objc func releaseArr() {
        cas = []
        cbs = []
        ccs = []
        cds = []
    }
    
//6    0.009955167770385742
//1   0.007562875747680664
//5    0.008865833282470703
//4    0.00854039192199707
//2    0.007955312728881836
//3    0.0084686279296875
    
    
//6    0.00855565071105957
//1    0.006780147552490234
//4    0.007841110229492188
//2    0.0074846744537353516
//3    0.0075147151947021484
//5    0.00818324089050293

    
//6    0.008449316024780273
//1    0.0066416263580322266
//3    0.007724761962890625
//5    0.007788658142089844
//2    0.0074040889739990234
//3    0.007723331451416016
    
    
//6    0.009873151779174805
//1    0.0071184635162353516
//4    0.008206605911254883
//3    0.008171319961547852
//2    0.007562398910522461
//4    0.008209466934204102
    
    
//6    0.00959467887878418
//1    0.006804943084716797
//4    0.00800943374633789
//3    0.007811307907104492
//2    0.007756948471069336
//5    0.008595466613769531

    
    @objc func check() {
        var ats: Double = 0
        var bts: Double = 0
        var cts: Double = 0
        var dts: Double = 0
        var ets: Double = 0
        var fts: Double = 0
        
        for _ in 0 ... 10 {
            let rst = once()
            ats += rst.0
            bts += rst.1
            cts += rst.2
            dts += rst.3
            ets += rst.4
            fts += rst.5
            sleep(1)
        }

        print(ats)
        print(bts)
        print(cts)
        print(dts)
        print(ets)
        print(fts)
        print("\n")
    }
    
    func once() -> (TimeInterval, TimeInterval, TimeInterval, TimeInterval, TimeInterval, TimeInterval) {
        
        let timea = Date.init().timeIntervalSince1970
        
        for _ in 0 ... 999 {
            let c = A()
            cas.append(c)
            res.append(c.a)
        }
        let timeb = Date.init().timeIntervalSince1970
        
        for _ in 0 ... 999 {
            let c = B()
            cbs.append(c)
            res.append(c.a)
        }
        let timec = Date.init().timeIntervalSince1970
        
        for _ in 0 ... 999 {
            let c = C()
            ccs.append(c)
            res.append(c.a!)
            
        }
        let timed = Date.init().timeIntervalSince1970
        
        for _ in 0 ... 999 {
            let c = C()
            ccs.append(c)
            if let s = c.a {
                res.append(s)
            }
        }
        let timee = Date.init().timeIntervalSince1970
        
        for _ in 0 ... 999 {
            let c = D()
            cds.append(c)
            res.append(c.a!)
            
        }
        let timef = Date.init().timeIntervalSince1970
        
        for _ in 0 ... 999 {
            let c = D()
            cds.append(c)
            if let s = c.a {
                res.append(s)
            }
        }
        let timeg = Date.init().timeIntervalSince1970
        
        return(timeb - timea, timec - timeb, timed - timec, timee - timed, timef - timee, timeg - timef)
        
    }
    
}


class A {
    var a = ""
    
    init() {
        a = "hahah"
    }
}

class B {
    let a: String
    
    init() {
        a = "hahah"
    }
}

class C {
    var a: String!
    
    init() {
        a = "hahah"
    }
}

class D {
    var a: String?
    
    init() {
        a = "hahah"
    }
}

