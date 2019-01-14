//
//  TestController.swift
//  RxSwiftLeaks
//
//  Created by biesx on 2018/12/5.
//  Copyright © 2018 biesx. All rights reserved.
//

import UIKit
import RxGesture
import RxSwift
import ReactorKit

class TestController: UIViewController, ReactorKit.View {
    var disposeBag = DisposeBag()
    
    typealias Reactor = TextReactor
    
    let vm = TestVM()
    
    let testView = TestView()
    
    let disposeBage = DisposeBag()
    
    func bind(reactor: TextReactor) {
        
        self.view.rx.tapGesture().asObservable()
            .flatMapFirst{ $0 }
            .map { _ in TextReactor.Action.request }
            .bind(to: reactor.action )
            .disposed(by: disposeBag)
        
        reactor.state.map({ $0.model })
            .distinctUntilChanged({ return $0.age == $1.age && $0.name == $1.name })
            .subscribe(onNext: { [weak self] (model) in
                self?.testView.setValue(model)
            }).disposed(by: disposeBag)
        
        reactor.state.map({ $0.isLoading })
            .distinctUntilChanged({ $0 == $1 })
            .subscribe(onNext: { (isV) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = isV
            }).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        testView.frame = self.view.bounds
        view.addSubview(testView)
    }
    
}
