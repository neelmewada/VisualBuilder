//
//  NSLayoutConstraintExtensions.swift
//  VisualBuilder
//
//  Created by Neel Mewada on 24/05/21.
//

import UIKit

extension NSLayoutConstraint {
    public func withPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}
