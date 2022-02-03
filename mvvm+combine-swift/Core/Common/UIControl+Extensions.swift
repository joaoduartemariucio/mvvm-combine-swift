//
//  UIControl+Extensions.swift
//  mvvm+combine-swift
//
//  Created by João Vitor Duarte Mariucio on 03/02/22.
//

import Combine
import Foundation
import UIKit

extension UIControl {

    class InteractionSubscription<S: Subscriber>: Subscription where S.Input == Void {

        private let subscriber: S?
        private let control: UIControl
        private let event: UIControl.Event

        init(subscriber: S,
             control: UIControl,
             event: UIControl.Event) {

            self.subscriber = subscriber
            self.control = control
            self.event = event

            self.control.addTarget(self, action: #selector(handleEvent), for: event)
        }

        @objc func handleEvent(_ sender: UIControl) {
            _ = subscriber?.receive(())
        }

        func request(_ demand: Subscribers.Demand) {}

        func cancel() {}
    }

    struct InteractionPublisher: Publisher {

        typealias Output = Void
        typealias Failure = Never

        private let control: UIControl
        private let event: UIControl.Event

        init(control: UIControl, event: UIControl.Event) {
            self.control = control
            self.event = event
        }

        func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, Void == S.Input {

            let subscription = InteractionSubscription(
                subscriber: subscriber,
                control: control,
                event: event
            )

            subscriber.receive(subscription: subscription)
        }
    }

    func publisher(for event: UIControl.Event) -> UIControl.InteractionPublisher {

        return InteractionPublisher(control: self, event: event)
    }
}
