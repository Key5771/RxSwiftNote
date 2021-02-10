//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by 김기현 on 2021/02/09.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    //    let observable: Observable<Int> = Observable<Int>.just(5)
//    let observable2: Observable<String> = Observable<String>.just("1")
//    let observable3: Observable<[Int]> = Observable<[Int]>.of([1, 2, 3])
//    let observable4: Observable<Int> = Observable<Int>.range(start: 3, count: 6)
    
    let disposeBag = DisposeBag()
    var result: String = ""
    
    enum FileReadError: Error {
        case fileNotFound
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let _ = observable.subscribe { event in
//            print("observable: \(event)")
//        }
//
//        let _ = observable2.subscribe { (event) in
//            print("observable2: \(event)")
//        }
//
//        let _ = observable3.subscribe { (event) in
//            print("observable3: \(event)")
//        }
//
//        let _ = observable4.subscribe { (event) in
//            print("observable4: \(event)")
//        }
//
//        let observable5 = Observable<Int>.create { (observer) -> Disposable in
//            observer.onNext(3)
//            observer.onNext(4)
//            observer.onNext(5)
//
//            observer.onCompleted()
//
//            return Disposables.create()
//        }
//
//        let _ = observable5.subscribe { (event) in
//            print("result: \(event)")
//        }
//
//        let observable6 = Observable.of(1, 2, 3)
//
//        let subscription = observable6.subscribe { (num) in
//            print("subscription: \(num)")
//        }
//
//        subscription.dispose()
        
        let _ = findFilePath(from: "key").subscribe { (result) in
            print(result)
            self.result = String(result)
        } onFailure: { (error) in
            print(error)
        }
    }
    
    func findFilePath(from name: String) -> Single<String> {
        return Single.create { (single) -> Disposable in
            guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                single(.failure(FileReadError.fileNotFound))
                return Disposables.create()
            }
            
            single(.success(path))
            
            return Disposables.create()
        }
    }
}

