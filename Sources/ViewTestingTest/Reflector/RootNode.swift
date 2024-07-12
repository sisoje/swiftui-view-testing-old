//
//  File.swift
//
//
//  Created by Lazar on 12/07/2024.
//

import Foundation
import SwiftUI

struct RootNode: ReflectionNodeWrapper {
    let node: ReflectionNode
}

@MainActor extension View {
    var bodyReflection: ReflectionNodeWrapper {
        RootNode(node: ReflectionNode(object: body))
    }
}

extension ReflectionNodeWrapper {
    func genericNodes(_ t: any Any.Type) -> [ReflectionNode] {
        let basename = String(reflecting: t).components(separatedBy: "<")[0]
        return node.allNodes.filter { $0.typename.components(separatedBy: "<")[0] == basename }
    }

    func valueNodes<T>(_ t: T.Type = T.self) -> [ValueNodeWrapper<T>] {
        node.allNodes.filter { $0.object is T }.map(ValueNodeWrapper.init)
    }

    var asyncActions: [ValueNodeWrapper< @Sendable () async -> Void>] { valueNodes() }

    var actions: [ValueNodeWrapper<() -> Void>] { valueNodes() }

    var strings: [ValueNodeWrapper<String>] { valueNodes() }

    var images: [ValueNodeWrapper<Image>] { valueNodes() }

    var texts: [ValueNodeWrapper<Text>] { valueNodes() }

    var bindings: [BindingNodeWrapper] {
        genericNodes(Binding<Any>.self).map(BindingNodeWrapper.init)
    }

    var toggles: [ToggleNodeWrapper] {
        genericNodes(Toggle<AnyView>.self).map(ToggleNodeWrapper.init)
    }

    var buttons: [ButtonNodeWrapper] {
        genericNodes(Button<AnyView>.self).map(ButtonNodeWrapper.init)
    }

    var refreshableModifiers: [RefreshableNodeWrapper] {
        func isRefreshableModifier(_ ref: ReflectionNode) -> Bool {
            let basename = ref.typename.components(separatedBy: "<")[0]
            return basename.hasPrefix("SwiftUI.") && basename.hasSuffix(".RefreshableModifier")
        }
        return node.allNodes.filter(isRefreshableModifier).map(RefreshableNodeWrapper.init)
    }
}
