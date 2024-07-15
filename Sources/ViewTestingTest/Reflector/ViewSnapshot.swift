//
//  File.swift
//  
//
//  Created by Lazar on 14/07/2024.
//

import SwiftUI

struct ViewSnapshot<T: View> {
    let view: ValueNodeWrapper<T>
    let body: ReflectionNodeWrapper
}
