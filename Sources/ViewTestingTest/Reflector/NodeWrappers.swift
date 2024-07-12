//
//  NodeWrappers.swift
//  Part2Tests
//
//  Created by Lazar on 09/07/2024.
//

import Foundation
import SwiftUI

protocol ReflectionNodeWrapper {
    var node: ReflectionNode { get }
}

struct BindingNodeWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    func castAs<T>(_ t: T.Type = T.self) -> Binding<T>? {
        node.object as? Binding<T>
    }

    func memoryCast<T>(_ t: T.Type = T.self) -> Binding<T> {
        CastingUtils.memoryCast(node.object, Binding<T>.self)
    }
}

struct RefreshableNodeWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    @MainActor func refresh() async {
        await asyncActions[0].value()
    }
}

struct ButtonNodeWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    func tap() {
        actions[0].value()
    }
}

struct ToggleNodeWrapper: ReflectionNodeWrapper {
    let node: ReflectionNode

    private var boolBinding: Binding<Bool> {
        let binding = bindings.first!
        if let boolBinding = binding.castAs(Bool.self) {
            return boolBinding
        }
        enum DummyEnum {
            case case0
            case case1
        }
        let dummyBinding = binding.memoryCast(DummyEnum.self)
        return Binding {
            dummyBinding.wrappedValue == .case0
        } set: {
            dummyBinding.wrappedValue = $0 ? .case0 : .case1
        }
    }

    func toggle() {
        boolBinding.wrappedValue.toggle()
    }

    var isOn: Bool {
        boolBinding.wrappedValue
    }
}

struct ValueNodeWrapper<T>: ReflectionNodeWrapper {
    let node: ReflectionNode

    var value: T {
        node.object as! T
    }
}

extension ValueNodeWrapper<Text> {
    var string: String {
        strings[0].value
    }
}
