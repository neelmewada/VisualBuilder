//
//  ViewControllerExtensions.swift
//  VisualBuilder
//
//  Created by Neel Mewada on 24/05/21.
//

import UIKit

extension VBHierarchyBuilder where Self: UIViewController {
    /// Rebuilds the hierarchy for this view.
    public func buildHierarchy() {
        clearHierarchy()
        buildHierarchy(hierarchyBuilder, parent: self.view)
    }
    
    private func clearHierarchy() {
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
    
    
    /// Builds the UIView hierarchy recursively.
    /// - Parameters:
    ///   - hierarchy: The hierarchy array, where each element is either a `UIView` or the tuple `(UIView, [Any])`.
    ///   - parent: The root parent to which subviews are added to.
    private func buildHierarchy(_ hierarchy: [Any], parent: UIView) {
        for item in hierarchy {
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
