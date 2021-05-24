//
//  VBConstraint.swift
//  VisualBuilder
//
//  Created by Neel Mewada on 24/05/21.
//

import UIKit

//infix operator |

public struct VBConstraint {
    var lhs: VBAnchor
    var rhs: VBAnchor
    var priority: UILayoutPriority = .required
    var relation: VBConstraintRelation = .equal
    
    public static func |(lhs: VBConstraint, rhs: Float) -> VBConstraint {
        var constraint = lhs
        constraint.priority = UILayoutPriority(rhs)
        return constraint
    }
}

public enum VBConstraintRelation {
    case equal
    case greaterThanOrEqualTo
    case lessThanOrEqualTo
}
