//
//  UIControl+Combine.swift
//  UIKit-Test
//
//  Created by 김인섭 on 2023/09/20.
//

import Combine
import UIKit

extension UIControl {
    
    func controlPublisher(for event: UIControl.Event) -> UIControl.EventPublisher {
        .init(control: self, event: event)
    }
    
    struct EventPublisher: Publisher {
        typealias Output = UIControl
        typealias Failure = Never
        
        let control: UIControl
        let event: UIControl.Event
        
        func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, UIControl == S.Input {
            let subscription = EventSubscription(control: control, subscriber: subscriber, event: event)
            subscriber.receive(subscription: subscription)
        }
    }
    
    fileprivate class EventSubscription<EventSubscriber: Subscriber>: Subscription where EventSubscriber.Input == UIControl, EventSubscriber.Failure == Never {
        
        let control: UIControl
        let event: UIControl.Event
        var subscriber: EventSubscriber?
        
        init(control: UIControl, subscriber: EventSubscriber, event: UIControl.Event) {
            self.control = control
            self.subscriber = subscriber
            self.event = event
            
            control.addTarget(self, action: #selector(handleEvent), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            control.removeTarget(self, action: #selector(handleEvent), for: event)
        }
        
        @objc func handleEvent() {
            _ = subscriber?.receive(control)
        }
    }
}
