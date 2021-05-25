//
//  AutoLayoutBuilder.swift
//  VisualBuilder
//
//

import UIKit

// MARK: - ConstraintGroup

public protocol VBConstraintGroup {
    var constraintGroup: [VBConstraint] { get }
}

extension VBConstraint: VBConstraintGroup {
    public var constraintGroup: [VBConstraint] { [self] }
}

extension Array: VBConstraintGroup where Element == VBConstraint {
    public var constraintGroup: [VBConstraint] { self }
}

// MARK: - AutoLayoutBuilder

@resultBuilder public struct AutoLayoutBuilder {
    
    public static func buildBlock(_ components: VBConstraintGroup...) -> [VBConstraint] {
        return components.flatMap{ $0.constraintGroup }
    }
    
    public static func buildOptional(_ components: [VBConstraintGroup]?) -> [VBConstraint] {
        return components?.flatMap{ $0.constraintGroup } ?? []
    }
    
    public static func buildEither(first components: [VBConstraintGroup]) -> [VBConstraint] {
        return components.flatMap{ $0.constraintGroup }
    }
    
    public static func buildEither(second components: [VBConstraintGroup]) -> [VBConstraint] {
        return components.flatMap{ $0.constraintGroup }
    }
}

// MARK: - VBLayoutBuilder protocol

/// Protocol implemented by UIViewController and UIView subclasses to enable Constraint Builder.
public protocol VBLayoutBuilder: NSObject {
    var currentConstraints: [NSLayoutConstraint] { get set }
    var constraintBuilder: [VBConstraint] { get }
    func buildConstraints()
    func clearConstraints()
}
