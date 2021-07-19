//
//  Timer.swift
//  SpaceTrivia
//
//  Created by Athlosn90 on 12/05/2021.
//  Copyright © 2021 AndreaSanna. All rights reserved.
//

import Foundation
import UIKit
import Combine

extension GameController {
    
    
    func StartTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                let cancellable = self.counterClass.publisher.filter{ $0 > 0}.sink { (value) in
                    print(value)
                    self.TimerLbl.text = String(value)
                    self.TimerLbl.textColor = .red
                }
                self.counterClass.decrease()
         }
    }
    
    func addTime() {
            let cancellable = self.counterClass.publisher.filter{ $0 > 0}.sink { (value) in
            print(value)
            self.TimerLbl.text = String(value)
            self.TimerLbl.textColor = .green
        }
        self.counterClass.increment()
    }
 
 
    
}

class Counter {
//    acts as both subject and publisher
    var publisher: AnyPublisher<Int, Never> {
//        Here we're "erasing" the information of which type
//        that our subject actually is, only letting our outside code know that its a read-only publisher
        
        subject.eraseToAnyPublisher()
    }
    
//    using private(set) we ensure that our value con only be written by Counter class but read by any other
    private(set) var value = 30 {
//        Whenever our property was set, we snd its new value to our subject/publisher
        didSet {subject.send(value)}
    }
    
    private let subject = PassthroughSubject<Int, Never>()
    
    func increment() {
        value += 5
    }
    
    func decrease() {
        value -= 1
    }
    
}
