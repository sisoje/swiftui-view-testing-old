//
//  File.swift
//  
//
//  Created by Lazar on 12/07/2024.
//

import SwiftUI

public enum ViewHosting {
    @MainActor public static var hostView: (@MainActor (@MainActor () -> any View) -> Void)!
}
