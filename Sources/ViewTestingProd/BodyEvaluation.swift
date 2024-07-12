//
//  SwiftUITestingSupport.swift
//  Part2
//
//  Created by Lazar on 04/06/2024.
//

import SwiftUI

extension Notification.Name {
    static let bodyEvaluationNotification = Notification.Name("bodyEvaluationNotification")
}

public extension View {
    func postBodyEvaluationNotification() {
        assert({
            Self._printChanges()
            NotificationCenter.default.post(name: .bodyEvaluationNotification, object: self)
        }() == ())
    }
}
