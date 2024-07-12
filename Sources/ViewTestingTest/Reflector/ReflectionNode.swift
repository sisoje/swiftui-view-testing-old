//
//  Reflection.swift
//  Part2Tests
//
//  Created by Lazar on 08/07/2024.
//

import Foundation

final class ReflectionNode {
    init(object: Any, label: String = "", depth: Int = 0, index: Int = 0) {
        self.index = index
        self.depth = depth
        self.object = object
        self.label = label
        self.typename = String(reflecting: type(of: object))
        self.mirror = Mirror(reflecting: object)
        self.children = mirror.children.enumerated().map { index, node in
            ReflectionNode(object: node.value, label: node.label ?? "", depth: depth + 1, index: index)
        }
        children.forEach { $0.parent = self }
    }

    weak var parent: ReflectionNode?
    let children: [ReflectionNode]
    let depth: Int
    let index: Int
    let label: String
    let object: Any
    let mirror: Mirror
    let typename: String
}

// MARK: - Predicates

// MARK: - Filtering

extension ReflectionNode {
    var allNodes: [ReflectionNode] {
        children.reduce([self]) { $0 + $1.allNodes }
    }
}
