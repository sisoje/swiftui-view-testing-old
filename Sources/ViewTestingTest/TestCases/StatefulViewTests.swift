@testable import ViewTestingProd
import XCTest
import SwiftUI

final class StatefulViewTests: XCTestCase {
    @MainActor override func setUp() async throws {
        guard ViewHosting.hostView != nil else {
            throw XCTSkip("stateful view need hosting")
        }
    }
}

@MainActor extension StatefulViewTests {
    func testToggle() async throws {
        struct DummyView: View {
            @State var isOn = false
            var body: some View {
                let _ = postBodyEvaluationNotification()
                Toggle("Test", isOn: $isOn)
            }
        }
        
        ViewHosting.hostView {
            DummyView()
        }
        
        let viewSnapshot = try await DummyView.getTestView().viewSnapshot
        let toggle = viewSnapshot.body.toggles[0]
        XCTAssertEqual(toggle.texts.map(\.string), ["Test"])
        XCTAssertEqual(viewSnapshot.view.value.isOn, false)
        toggle.toggle()
        XCTAssertEqual(viewSnapshot.view.value.isOn, true)
    }
    
    func testButton() async throws {
        struct DummyView: View {
            @State var counter = 0
            var body: some View {
                let _ = postBodyEvaluationNotification()
                Button("Add") { counter += 1 }
            }
        }
        
        ViewHosting.hostView {
            DummyView()
        }
        
        let viewSnapshot = try await DummyView.getTestView().viewSnapshot
        let button = viewSnapshot.body.buttons[0]
        XCTAssertEqual(button.texts.map(\.string), ["Add"])
        XCTAssertEqual(viewSnapshot.view.value.counter, 0)
        button.tap()
        XCTAssertEqual(viewSnapshot.view.value.counter, 1)
    }
}
