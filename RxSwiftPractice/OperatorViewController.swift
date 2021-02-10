//
//  OperatorViewController.swift
//  RxSwiftPractice
//
//  Created by 김기현 on 2021/02/09.
//

import UIKit
import RxSwift

class OperatorViewController: UIViewController {

    let observable: Observable<Int> = Observable<Int>.of(1, 2, 3, 4, 5, 6)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Filterling Operator
        
        // Operator => filter
        print("filter")
        let _ = observable.filter { (num) -> Bool in
            num % 2 == 0
        }
        .subscribe (onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
        
        // Operator => skip
        print("skip")
        let _ = observable
            .skip(2)
            .subscribe(onNext: {
                print($0)
            })
        
        // Operator => skipWhile
        print("skipWhile")
        let _ = observable.skip { (num) -> Bool in
            num < 5
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
        
        // Operator => take
        print("take")
        let _ = observable
            .take(2)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        // Operator => takeWhile
        print("takeWhile")
        let _ = observable
            .take(while: { $0 % 6 < 5 })
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        // Operator => distinctUntilChanged(연달아 같은 값이 나오는 것을 방지)
        print("distinctUntilChanged")
        let _ = observable
            .distinctUntilChanged()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        // Operator => throttle(:_scheduler)
        // 특정시간동안 발생한 이벤트 중 가장 최신의 이벤트를 방출
        print("throttle(:_scheduler)")
        
        
        
        // MARK: - Transforming Operator
        
        // Operator => map
        let _ = observable
            .map {
                $0 * 10
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        // Operator => flatMap
        print("flatMap")
        struct Student {
            var score: BehaviorSubject<Int>
        }
        
        let ryan = Student(score: BehaviorSubject(value: 80))
        let charlotte = Student(score: BehaviorSubject(value: 80))
        
        let student = PublishSubject<Student>()
        
        student
            .flatMap {
                $0.score
            }
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        student.onNext(ryan)
        ryan.score.onNext(85)
        
        student.onNext(charlotte)
        ryan.score.onNext(95)
        charlotte.score.onNext(100)
        
        // Operator => flatMapLatest() flatMap에서 가장 최신의 값만 확인하고 싶을 때 사용
        // 새로운 Observable을 생성하면 자동적으로 이전의 Observable 구독을 해지
        print("flatMapLatest")
        
        struct Student2 {
            var score: BehaviorSubject<Int>
        }
        
        let ryan2 = Student2(score: BehaviorSubject(value: 80))
        let charlotte2 = Student2(score: BehaviorSubject(value: 80))
        
        let student2 = PublishSubject<Student2>()
        
        student2
            .flatMapLatest {
                $0.score
            }
            .subscribe(onNext: {
                print("aaaa")
                print($0)
            })
            .disposed(by: disposeBag)
        
        student2.onNext(ryan2)
        ryan2.score.onNext(85)
        
        student2.onNext(charlotte2)
        ryan2.score.onNext(95)
        charlotte2.score.onNext(100)
        
        
        // MARK: - Combining Operators
        
        // Operator => .concat(_:) 첫번째 sequence가 완료될 때까지 구독하고 다음 sequence를 같은 방법으로 구독
        print(".concat(_:)")
        let first = Observable.of(1, 2, 3)
        let second = Observable.of(4, 5, 6)
        
        // #1
        let concatObservable = Observable.concat([first, second])
        
        concatObservable
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        print("==================")
        
        // #2
        let concatObservable2 = first.concat(second)
        
        concatObservable2
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        
        // Operator => merge() sequence를 합치는 가장 쉬운 방법
        print("merge")
        
        let mergeFirst = Observable.of(1, 2, 3)
        let mergeSecond = Observable.of(4, 5, 6)
        
        Observable
            .merge(mergeFirst, mergeSecond)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        // Operator => combineLatest 여러 Observable에서 가장 최신의 값을 병합하여 방출
        print("combineLatest")
        let combineFirst = Observable.of(1, 2, 3, 4)
        let combineSecond = Observable.of("A", "B", "C")
        
        Observable
            .combineLatest(combineFirst, combineSecond)
            .subscribe(onNext: {
                print("\($0)" + $1)
            })
            .disposed(by: disposeBag)
        
        
        // Operator => zip 발생 순서가 같은 이벤트끼리 병합하여 방출
        print("zip")
        let zipFirst = Observable.of(1, 2, 3, 4)
        let zipSecond = Observable.of("A", "B", "C")
        
        Observable
            .zip(zipFirst, zipSecond)
            .subscribe(onNext: {
                print("\($0)" + $1)
            })
            .disposed(by: disposeBag)
        
        // Operator => withLatestFrom(_:) 한쪽 Observable의 이벤트가 발생했을 때 두 개의 Observable을 병합해주는 메서드
        print("withLatestFrom(_:)")
        
        
        // Operator => .scan() 값을 저장해 가지고 있을 수 있고, 그 값을 통해 이벤트를 변형할 수 있음.
        // 변형하는 이벤트의 타입은 원본 이벤트 타입과 같아야 함
        print(".scan(_:)")
        let scanObservable = Observable.of(1, 2, 3, 4, 5)
        
        scanObservable
            .scan(0) { $0 + $1 }
            .subscribe(onNext: { num in
                print(num)
            })
            .disposed(by: disposeBag)
    }
}
