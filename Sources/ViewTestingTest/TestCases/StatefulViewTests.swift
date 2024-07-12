@testable import ViewTestingProd
import SwiftUI
import XCTest

class StatefulViewTests: XCTestCase {
    @MainActor override func setUp() async throws {
        guard ViewHosting.hostView != nil else {
            throw XCTSkip("stateful view need hosting")
        }
    }
}

@MainActor extension StatefulViewTests {
    func testState() async throws {
        struct DummyView: View {
            @State var counter = 0
            var body: some View {
                let _ = postBodyEvaluationNotification()
                Button("Count: \(counter)") { counter += 1 }
            }
        }
        
        ViewHosting.hostView {
            DummyView()
        }
        
        let dummyView = try await DummyView.getTestView()
        let button = dummyView.bodyReflection.buttons[0]
        XCTAssertEqual(button.texts.map(\.string), ["Count: %lld"])
        XCTAssertEqual(dummyView.counter, 0)
        button.tap()
        XCTAssertEqual(dummyView.counter, 1)
    }
}
