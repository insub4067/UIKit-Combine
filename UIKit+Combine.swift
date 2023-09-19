//
//  UIKit+.swift
//  UIKit-Test
//
//  Created by 김인섭 on 2023/09/20.
//

import Combine
import UIKit

extension UITextField {

    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextField.textDidChangeNotification,
            object: self
        )
        .compactMap { $0.object as? UITextField }
        .map { $0.text ?? "" }
        .eraseToAnyPublisher()
    }
}

extension UITextView {
 
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextView.textDidChangeNotification,
            object: self
        )
        .compactMap{ $0.object as? UITextView}
        .map{ $0.text ?? "" }
        .eraseToAnyPublisher()
     }
}

extension UIButton {
    
    var tapPublisher: AnyPublisher<Void, Never> {
        controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
