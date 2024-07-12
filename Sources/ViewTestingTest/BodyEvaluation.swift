//
//  SwiftUITestingSupport.swift
//  Part2Tests
//
//  Created by Lazar on 04/06/2024.
//

import SwiftUI
@testable import ViewTestingProd

extension Notification: @unchecked Sendable {
    // this silences the "notification is not sendable" warning
}

extension NotificationCenter {
    struct TestNotificationTimeoutError: Error {}
    
    @MainActor func getTestView<T>(_ timeout: TimeInterval) async throws -> T {
        let timeoutTask = Task {
            try await Task.sleep(nanoseconds: UInt64(timeout*1000*1000*1000))
            // if timeout happens we post nil to unblock the await
            post(name: .bodyEvaluationNotification, object: nil)
        }
        defer { timeoutTask.cancel() }
        for await n in notifications(named: .bodyEvaluationNotification) {
            guard let v = n.object else {
                throw TestNotificationTimeoutError()
            }
            guard let v = v as? T else {
                continue
            }
            return v
        }
        fatalError()
    }
}

extension View {
    @MainActor static func getTestView(timeout: TimeInterval = 1) async throws -> Self {
        // normally we get notification immediately but if there is any problem we dont want to wait forever
        try await NotificationCenter.default.getTestView(timeout)
    }
}
