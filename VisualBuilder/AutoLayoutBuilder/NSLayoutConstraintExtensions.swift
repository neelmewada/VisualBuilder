//
//  NSLayoutConstraintExtensions.swift
//  VisualBuilder
//
//

import UIKit

extension NSLayoutConstraint {
    public func withPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
    
    public func isEqual(to constraint: VBConstraint) -> Bool {
        if let firstItem = self.firstItem as? UIView {
            if firstItem != constraint.lhs.view && firstItem != constraint.rhs.view {
                return false
            }
        }
        if let secondItem = self.secondItem as? UIView {
            if secondItem != constraint.lhs.view && secondItem != constraint.rhs.view {
                return false
            }
        }
        if self.constant != constraint.rhs.constant {
            return false
        }
        if self.priority != constraint.priority {
            return false
        }
        if self.relation != constraint.relation.getRelation() {
            return false
        }
        return true
    }
}
