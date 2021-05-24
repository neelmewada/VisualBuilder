//
//  VisualBuilder.swift
//  VisualBuilder
//
//  Created by Neel Mewada on 24/05/21.
//

import UIKit

/// The main protocol to conform to, to implement Hierarchy builder and auto-layout builder.
public protocol VisualBuilder: VBHierarchyBuilder, VBLayoutBuilder {
    func buildLayout()
}

extension VisualBuilder {
    public func buildLayout() {
        buildHierarchy()
        buildConstraints()
    }
}
