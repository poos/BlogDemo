//
//
//
//
//  Created by biesx on 2018/8/30.
//  Copyright © 2018年 biesx. All rights reserved.
//

import Moya
import RxSwift
import ObjectMapper

enum ViewModelLoadType {
    case datasOne
    case datasTwo
    case datasTwoPullDown
    case datasTwoPullUp
}

typealias TypeClouse = (ViewModelLoadType) -> Void

class ViewModel: BaseViewModel {
    fileprivate(set) var datasOne = [ModelOne]()
    fileprivate(set) var datasTwo = [ModelTwo]()

    var message = "暂无新内容"

    var loadBegin: TypeClouse = { _ in  }
    var noNet: TypeClouse = { _ in  }
    var normal: TypeClouse = { _ in  }
    var noMore: TypeClouse = { _ in  }

}


extension ViewModel {
    // can be many...
    func requestMoreFollowUsers() {
        request(.datasTwoPullDown, MultiTarget(TwoAPI.list([:])), success: { [weak self] json in
            if let model = ModelTwo(JSON: json), model.data.count > 0 {
                self?.datasTwo = model.data
                self?.message = "更新\(model.data)条新内容"
                self?.normal(.datasTwoPullDown)
            } else {
                self?.message = "暂无新内容"
                self?.noNet(.datasTwoPullDown)
            }
        })
    }
}


extension ViewModel {
    // api
    private func request(_ type: ViewModelLoadType, _ target: MultiTarget, success successCallback: @escaping (JsonObject) -> Void) {
        loadBegin(type)
        request(target, success: { (json) in
            successCallback(json)//在block中具体分析调用.normal()
        }, error: { [weak self] (_) in
            self?.noNet(type)
            }, failure: { [weak self] (_) in
                self?.noNet(type)
        })
    }
}
