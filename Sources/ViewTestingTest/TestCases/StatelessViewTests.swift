import SwiftUI
import XCTest

class StatelessViewTests: XCTestCase {}

@MainActor extension StatelessViewTests {
    func testBinding() {
        struct DummyView: View {
            @Binding var counter: Int
            var body: some View {
                Button("Count: \(counter)") { counter += 1 }
            }
        }
        
        let dummyView = DummyView(counter: .variable(0))
        let button = dummyView.bodyReflection.buttons[0]
        XCTAssertEqual(button.texts.map(\.string), ["Count: %lld"])
        XCTAssertEqual(dummyView.counter, 0)
        button.tap()
        XCTAssertEqual(dummyView.counter, 1)
    }
}
