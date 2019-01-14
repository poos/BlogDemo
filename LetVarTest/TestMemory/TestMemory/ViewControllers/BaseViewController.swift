//
//  BaseViewController.swift
//  TestMemory
//
//  Created by biesx on 2018/12/14.
//  Copyright © 2018 biesx. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel.init(frame: UIScreen.main.bounds)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    var num = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
    }
    
    @objc func tapAction() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
