//
//  SecondViewController.swift
//  RxSwiftPractice
//
//  Created by 김기현 on 2021/02/09.
//

import UIKit
import RxSwift

class SecondViewController: UIViewController {

//    let subject = PublishSubject<Int>()
//    let subject = BehaviorSubject<Int>(value: 5)
    let subject = ReplaySubject<Int>.create(bufferSize: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - PublishSubject => 구독 이후부터 completed 되기 직전까지 모든 값 넘겨받음
//        let _ = subject.subscribe { (num) in
//            print("subjectOne: ", num)
//        }
//
//        subject.onNext(1)
//        subject.onNext(2)
//
//        let _ = subject.subscribe { (num) in
//            print("subjectTwo: ", num)
//        }
//
//        subject.onNext(3)
//        subject.onNext(4)
//        subject.onNext(5)
        
//        let _ = subject.subscribe { (num) in
//            print("subjectOne: ", num)
//        } onError: { (error) in
//            print("subjectOne Error: ", error)
//        } onCompleted: {
//            print("subjectOne onCompleted")
//        }
//
//        subject.onNext(1)
//        subject.onNext(2)
//
//        // 여기서 이미 completed이기 때문에 밑ㅌ에 코드에서는 onCompleted 일때만 출력
//        subject.onCompleted()
//
//        let _ = subject.subscribe { (num) in
//            print("subjectTwo: ", num)
//        } onError: { (error) in
//            print("subjectTwo Error: ", error)
//        } onCompleted: {
//            print("subjectTwo onCompleted")
//        }
//
//        subject.onNext(3)
//        subject.onNext(4)
//        subject.onNext(5)
        
        // MARK: - BehaviorSubject => 구독하기 바로 직전 값만 넘겨받음
//        let _ = subject.subscribe { (num) in
//            print("subjectOne: ", num)
//        } onError: { (error) in
//            print("subjectOne Error", error)
//        } onCompleted: {
//            print("subjectOne onCompleted")
//        }
//
//        subject.onNext(6)
//        subject.onNext(7)
//        subject.onNext(8)
//
//        let _ = subject.subscribe { (num) in
//            print("subjectTwo: ", num)
//        } onError: { (error) in
//            print("subjectTwo Error", error)
//        } onCompleted: {
//            print("subjectTwo onCompleted")
//        }
//
//        subject.onNext(9)
//        subject.onNext(10)

        // MARK: - ReplaySubject => 일정 크기의 버퍼나 캐시만큼 자료를 저장
        subject.onNext(1)
        subject.onNext(2)
        subject.onNext(3)
        subject.onNext(4)
        subject.onNext(5)
        subject.onNext(6)
        
        let _ = subject.subscribe { (num) in
            print(num)
        }
        
        subject.onNext(7)
        subject.onNext(8)
        subject.onNext(9)
    }
}
