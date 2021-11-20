//
//  VBConstraint.swift
//  VisualBuilder
//
//

import UIKit

typealias VBConstraintAnimation = () -> ()

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
    
    func getRelation() -> NSLayoutConstraint.Relation {
        switch self {
        case .equal:
            return .equal
        case .greaterThanOrEqualTo:
            return .greaterThanOrEqual
        case .lessThanOrEqualTo:
            return .lessThanOrEqual
        }
    }
}
