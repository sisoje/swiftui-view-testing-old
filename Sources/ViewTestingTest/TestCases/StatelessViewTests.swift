import SwiftUI
import XCTest

class StatelessViewTests: XCTestCase {}

@MainActor extension StatelessViewTests {
    func testToggle() {
        struct DummyView: View {
            @Binding var isOn: Bool
            var body: some View {
                Toggle("Test", isOn: $isOn)
            }
        }
        
        let viewSnapshot = DummyView(isOn: .variable(false)).viewSnapshot
        let toggle = viewSnapshot.body.toggles[0]
        XCTAssertEqual(toggle.texts.map(\.string), ["Test"])
        XCTAssertEqual(viewSnapshot.view.value.isOn, false)
        toggle.toggle()
        XCTAssertEqual(viewSnapshot.view.value.isOn, true)
    }
    
    func testButton() {
        struct DummyView: View {
            @Binding var counter: Int
            var body: some View {
                Button("Add") { counter += 1 }
            }
        }
        
        let viewSnapshot = DummyView(counter: .variable(0)).viewSnapshot
        let button = viewSnapshot.body.buttons[0]
        XCTAssertEqual(button.texts.map(\.string), ["Add"])
        XCTAssertEqual(viewSnapshot.view.value.counter, 0)
        button.tap()
        XCTAssertEqual(viewSnapshot.view.value.counter, 1)
    }
}
