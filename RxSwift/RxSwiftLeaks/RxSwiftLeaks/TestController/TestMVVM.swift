//
//  TestMVVM.swift
//  RxSwiftLeaks
//
//  Created by biesx on 2018/12/5.
//  Copyright © 2018 biesx. All rights reserved.
//

import UIKit
import RxSwift
import ReactorKit

struct TestModel {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    static func test() -> TestModel {
        let age = arc4random() % 39 + 1
        return TestModel.init(name: "people\(age)", age: Int(age))
    }
}

class TestView: UIView {
    let name: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let age: UILabel = {
        let label = UILabel.init()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    func setValue(name: String, age: Int) {
        self.name.text = name
        self.age.text = "\(age)"
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(name)
        addSubview(age)
        var frame = self.frame
        frame.size.height /= 2
        name.frame = frame
        frame.origin.y = frame.size.height
        age.frame = frame
    }
}

extension TestView {
    func setValue(_ textModel : TestModel) {
        setValue(name: textModel.name, age: textModel.age)
    }
}


class TestVM: NSObject {
    
    let testPublish = PublishSubject<TestModel>()
    
    func test() {
        testPublish.onNext(TestModel.test())
    }
}



final class TextReactor: Reactor {
    
    enum Action {
        case request
    }
    
    enum Mutation {
        case reset
        case setLoading(Bool)
    }
    
    struct State {
        var model: TestModel
        var times: Int
        var isLoading: Bool
    }
    
    let initialState: TextReactor.State
    
    init() {
        let initModel = TestModel.init(name: "none", age: 0)
        self.initialState = State(model: initModel, times: 0, isLoading: false)
    }
    
    // MARK: actions -> Mitation
    
    func mutate(action: TextReactor.Action) -> Observable<TextReactor.Mutation> {
        return Observable.concat([
            Observable.just(Mutation.setLoading(true)),
            Observable.just(Mutation.reset).delay(0.5, scheduler: MainScheduler.instance),
            Observable.just(Mutation.setLoading(false))
            ])
    }
    
    func reduce(state: TextReactor.State, mutation: TextReactor.Mutation) -> TextReactor.State {
        var state = state
        
        switch mutation {
        case .reset:
            state.model = TestModel.test()
        case .setLoading(let isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}
