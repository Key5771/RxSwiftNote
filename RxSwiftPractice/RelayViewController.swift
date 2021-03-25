//
//  RelayViewController.swift
//  RxSwiftPractice
//
//  Created by 김기현 on 2021/02/09.
//

import UIKit
import RxSwift
import RxCocoa

class RelayViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - PublishRelay
        // PublishSubject를 wrapping해서 가지고 있음
        // Subject는 .completed나 .error를 받으면 subscribe이 종료
        // PublishRelay는 dispose 되기 전까지 계속 작동하기 때문에 UIEvent에서 사용하기 적절
        
        
        // MARK: - BehaviorRelay
        // BehaviorSubject를 wrapping해서 가지고 있음
        // .value를 사용해 현재의 값을 꺼낼 수 있음
        // Variable이 deprecate 되면서 BehaviorRelay를 대신 사용
        // .value의 경우 get-only-property
        // value를 변경하기 위해서 .accept()를 사용
    }
}
