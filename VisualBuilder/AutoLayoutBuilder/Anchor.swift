//
//  Anchor.swift
//  VisualBuilder
//
//

import UIKit

// MARK: - VBAnchor

public struct VBAnchor {
    // MARK: - Properties
    
    var view: UIView? = nil
    var type: VBAnchorType = .constant
    var usesSafeArea: Bool = false
    
    // Used for RHS only
    var constant: CGFloat = 0
    var multiplier: CGFloat = 1
    
    // MARK: - Helpers
    
    /// True if it is rightAnchor, or bottomAnchor. i.e. the constant should be negative to apply an inset.
    public var isNegativeAnchor: Bool {
        return type == .right || type == .bottom
    }
    
    public var isXAxisAnchor: Bool {
        return type == .left || type == .right || type == .centerX
    }
    
    public var isYAxisAnchor: Bool {
        return type == .top || type == .bottom || type == .centerY
    }
    
    public var isDimensionAnchor: Bool {
        return type == .width || type == .height
    }
    
    public var isConstant: Bool {
        return type == .constant
    }
    
    public var xAxisAnchor: NSLayoutXAxisAnchor? {
        switch type {
        case .left:
            return !usesSafeArea ? view?.leftAnchor : view?.safeAreaLayoutGuide.leftAnchor
        case .right:
            return !usesSafeArea ? view?.rightAnchor : view?.safeAreaLayoutGuide.rightAnchor
        case .centerX:
            return !usesSafeArea ? view?.centerXAnchor : view?.safeAreaLayoutGuide.centerXAnchor
        default:
            return nil
        }
    }
    
    public var yAxisAnchor: NSLayoutYAxisAnchor? {
        switch type {
        case .top:
            return !usesSafeArea ? view?.topAnchor : view?.safeAreaLayoutGuide.topAnchor
        case .bottom:
            return !usesSafeArea ? view?.bottomAnchor : view?.safeAreaLayoutGuide.bottomAnchor
        case .centerY:
            return !usesSafeArea ? view?.centerYAnchor : view?.safeAreaLayoutGuide.centerYAnchor
        default:
            return nil
        }
    }
    
    public var dimensionAnchor: NSLayoutDimension? {
        if type == .width {
            return !usesSafeArea ? view?.widthAnchor : view?.safeAreaLayoutGuide.widthAnchor
        } else if type == .height {
            return !usesSafeArea ? view?.heightAnchor : view?.safeAreaLayoutGuide.heightAnchor
        }
        return nil
    }
    
    // MARK: - Operators
    
    public static func ==(lhs: VBAnchor, rhs: VBAnchor) -> VBConstraint {
        return VBConstraint(lhs: lhs, rhs: rhs, relation: .equal)
    }
    
    public static func ==(lhs: VBAnchor, rhs: CGFloat) -> VBConstraint {
        return VBConstraint(lhs: lhs, rhs: VBAnchor(view: nil, type: .constant, constant: rhs), relation: .equal)
    }
    
    public static func <=(lhs: VBAnchor, rhs: VBAnchor) -> VBConstraint {
        return VBConstraint(lhs: lhs, rhs: rhs, relation: .lessThanOrEqualTo)
    }
    
    public static func <=(lhs: VBAnchor, rhs: CGFloat) -> VBConstraint {
        return VBConstraint(lhs: lhs, rhs: VBAnchor(view: nil, type: .constant, constant: rhs), relation: .lessThanOrEqualTo)
    }
    
    public static func >=(lhs: VBAnchor, rhs: VBAnchor) -> VBConstraint {
        return VBConstraint(lhs: lhs, rhs: rhs, relation: .greaterThanOrEqualTo)
    }
    
    public static func >=(lhs: VBAnchor, rhs: CGFloat) -> VBConstraint {
        return VBConstraint(lhs: lhs, rhs: VBAnchor(view: nil, type: .constant, constant: rhs), relation: .greaterThanOrEqualTo)
    }
    
    public static func +(lhs: VBAnchor, rhs: CGFloat) -> VBAnchor {
        var result = lhs
        result.constant = rhs
        return result
    }
    
    public static func -(lhs: VBAnchor, rhs: CGFloat) -> VBAnchor {
        var result = lhs
        result.constant = -rhs
        return result
    }
    
    public static func *(lhs: VBAnchor, rhs: CGFloat) -> VBAnchor {
        var result = lhs
        result.multiplier = rhs
        return result
    }
    
    public static func /(lhs: VBAnchor, rhs: CGFloat) -> VBAnchor {
        var result = lhs
        result.multiplier = 1 / rhs
        return result
    }
}

// MARK: - VBAnchorType

public enum VBAnchorType: String {
    case top
    case left
    case bottom
    case right
    case width
    case height
    case centerX
    case centerY
    case constant
}

// MARK: - [VBAnchor] Extension

extension Array where Element == VBAnchor {
    
    public static func ==(lhs: [VBAnchor], rhs: [VBAnchor]) -> [VBConstraint] {
        if lhs.count != rhs.count {
            return []
        }
        var constraints = [VBConstraint]()
        let count = lhs.count
        
        for i in 0..<count {
            constraints.append(VBConstraint(lhs: lhs[i], rhs: rhs[i]))
        }
        
        return constraints
    }
    
    public static func +(lhs: [VBAnchor], rhs: CGFloat) -> [VBAnchor] {
        var result = lhs
        for i in 0..<result.count {
            result[i].constant = rhs * (result[i].isNegativeAnchor ? 1 : -1) // We need "expansion" effect here.
        }
        return result
    }
    
    public static func -(lhs: [VBAnchor], rhs: CGFloat) -> [VBAnchor] {
        var result = lhs
        for i in 0..<result.count {
            result[i].constant = rhs * (result[i].isNegativeAnchor ? -1 : 1) // We need "contraction" effect here.
        }
        return result
    }
    
    public static func *(lhs: [VBAnchor], rhs: CGFloat) -> [VBAnchor] {
        var result = lhs
        for i in 0..<result.count {
            result[i].multiplier = rhs
        }
        return result
    }
    
    public static func /(lhs: [VBAnchor], rhs: CGFloat) -> [VBAnchor] {
        var result = lhs
        for i in 0..<result.count {
            result[i].multiplier = 1 / rhs
        }
        return result
    }
}
