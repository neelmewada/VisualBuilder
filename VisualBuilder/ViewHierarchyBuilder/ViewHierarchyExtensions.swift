//
//  ViewExtensions.swift
//  VisualBuilder
//
//  Created by Neel Mewada on 24/05/21.
//

import UIKit

// MARK: - VBHierarchyBuilder

extension VBHierarchyBuilder where Self: UIView {
    /// Rebuilds the hierarchy for this view.
    public func buildHierarchy() {
        clearHierarchy()
        buildHierarchy(hierarchyBuilder, parent: self)
    }
    
    public func clearHierarchy() {
        clearHierarchy(currentHierarchy)
    }
    
    private func clearHierarchy(_ subviews: [Any]) {
        for item in subviews {
            if let view = item as? UIView {
                view.removeFromSuperview()
            } else if let tuple = item as? (UIView, [Any]) {
                clearHierarchy(tuple.1)
                tuple.0.removeFromSuperview()
            }
        }
    }
    
    /// Builds hierarchy recursively.
    private func buildHierarchy(_ array: [Any], parent: UIView) {
        for item in array {
            if let view = item as? UIView {
                parent.addSubview(view)
                currentHierarchy.append(view)
            } else if let tuple = item as? (UIView, [Any]) {
                currentHierarchy.append(tuple)
                parent.addSubview(tuple.0)
                buildHierarchy(tuple.1, parent: tuple.0)
            }
        }
    }
}

// MARK: - UIView

extension UIView {
    public func content(@ViewHierarchyBuilder _ children: () -> [Any]) -> Any {
        return (self, children())
    }
}
