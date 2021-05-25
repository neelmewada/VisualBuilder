//
//  ViewExtensions.swift
//  VisualBuilder
//
//

import UIKit

// MARK: - Anchor Extensions

extension UIView {
    
    /// Use it to create constraints for all 4 anchors: top, left, bottom, right.
    public var edges: [VBAnchor] {
        [top, bottom, left, right]
    }
    
    /// Use it to create constraints with safeAreaLayoutGuide for all 4 anchors: top, left, bottom, right.
    public var safeEdges: [VBAnchor] {
        [topSafe, bottomSafe, leftSafe, rightSafe]
    }
    
    public var size: [VBAnchor] {
        [width, height]
    }
    
    public var left: VBAnchor {
        VBAnchor(view: self, type: .left)
    }
    
    public var leftSafe: VBAnchor {
        VBAnchor(view: self, type: .left, usesSafeArea: true)
    }
    
    public var right: VBAnchor {
        VBAnchor(view: self, type: .right)
    }
    
    public var rightSafe: VBAnchor {
        VBAnchor(view: self, type: .right, usesSafeArea: true)
    }
    
    public var top: VBAnchor {
        VBAnchor(view: self, type: .top)
    }
    
    public var topSafe: VBAnchor {
        VBAnchor(view: self, type: .top, usesSafeArea: true)
    }
    
    public var bottom: VBAnchor {
        VBAnchor(view: self, type: .bottom)
    }
    
    public var bottomSafe: VBAnchor {
        VBAnchor(view: self, type: .bottom, usesSafeArea: true)
    }
    
    public var centerX: VBAnchor {
        VBAnchor(view: self, type: .centerX)
    }
    
    public var centerY: VBAnchor {
        VBAnchor(view: self, type: .centerY)
    }
    
    public var height: VBAnchor {
        VBAnchor(view: self, type: .height)
    }
    
    public var width: VBAnchor {
        VBAnchor(view: self, type: .width)
    }
}


// MARK: - VBLayoutBuilder

extension VBLayoutBuilder where Self: UIView {
    
    public func buildConstraints() {
        clearConstraints()
        
        var constraints = [NSLayoutConstraint]()
        
        for constraint in constraintBuilder {
            var constraintsToRemove = [NSLayoutConstraint]()
            
            // Check if this constraint is already active
            for currentlyActiveConstraint in currentConstraints {
                if currentlyActiveConstraint.isEqual(to: constraint) { // if it is present, no need to re-add it
                    continue
                } else { // else remove the currently active constraint
                    constraintsToRemove.append(currentlyActiveConstraint)
                }
            }
            
            NSLayoutConstraint.deactivate(constraintsToRemove)
            currentConstraints.removeAll { x in
                return constraintsToRemove.contains(x)
            }
            
            constraints.append(contentsOf: createConstraints(constraint))
        }
        
        currentConstraints.append(contentsOf: constraints)
        NSLayoutConstraint.activate(currentConstraints)
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    private func createConstraints(_ constraint: VBConstraint) -> [NSLayoutConstraint] {
        guard let _ = constraint.lhs.view else { return [] }
        
        var constraints = [NSLayoutConstraint]()
        let lhs = constraint.lhs
        let rhs = constraint.rhs
        let relation = constraint.relation
        lhs.view?.translatesAutoresizingMaskIntoConstraints = false
        rhs.view?.translatesAutoresizingMaskIntoConstraints = false
        
        if let lhsXAxisAnchor = lhs.xAxisAnchor, let rhsXAxisAnchor = rhs.xAxisAnchor, lhs.isXAxisAnchor, rhs.isXAxisAnchor {
            
            if relation == .equal {
                constraints.append(lhsXAxisAnchor.constraint(equalTo: rhsXAxisAnchor, constant: rhs.constant).withPriority(constraint.priority))
            } else if relation == .greaterThanOrEqualTo {
                constraints.append(lhsXAxisAnchor.constraint(greaterThanOrEqualTo: rhsXAxisAnchor, constant: rhs.constant).withPriority(constraint.priority))
            } else if relation == .lessThanOrEqualTo {
                constraints.append(lhsXAxisAnchor.constraint(lessThanOrEqualTo: rhsXAxisAnchor, constant: rhs.constant).withPriority(constraint.priority))
            }
            
        } else if let lhsYAxisAnchor = lhs.yAxisAnchor, let rhsYAxisAnchor = rhs.yAxisAnchor, lhs.isYAxisAnchor, rhs.isYAxisAnchor {
            
            if relation == .equal {
                constraints.append(lhsYAxisAnchor.constraint(equalTo: rhsYAxisAnchor, constant: rhs.constant).withPriority(constraint.priority))
            } else if relation == .greaterThanOrEqualTo {
                constraints.append(lhsYAxisAnchor.constraint(greaterThanOrEqualTo: rhsYAxisAnchor, constant: rhs.constant).withPriority(constraint.priority))
            } else if relation == .lessThanOrEqualTo {
                constraints.append(lhsYAxisAnchor.constraint(lessThanOrEqualTo: rhsYAxisAnchor, constant: rhs.constant).withPriority(constraint.priority))
            }
            
        } else if let lhsDimension = lhs.dimensionAnchor, lhs.isDimensionAnchor, rhs.isConstant {
            
            if relation == .equal {
                constraints.append(lhsDimension.constraint(equalToConstant: rhs.constant).withPriority(constraint.priority))
            } else if relation == .greaterThanOrEqualTo {
                constraints.append(lhsDimension.constraint(greaterThanOrEqualToConstant: rhs.constant).withPriority(constraint.priority))
            } else if relation == .lessThanOrEqualTo {
                constraints.append(lhsDimension.constraint(lessThanOrEqualToConstant: rhs.constant).withPriority(constraint.priority))
            }
            
        } else if let lhsDimension = lhs.dimensionAnchor, lhs.isDimensionAnchor, let rhsDimension = rhs.dimensionAnchor, rhs.isDimensionAnchor {
            
            if relation == .equal {
                constraints.append(lhsDimension.constraint(equalTo: rhsDimension, multiplier: rhs.multiplier, constant: rhs.constant).withPriority(constraint.priority))
            } else if relation == .greaterThanOrEqualTo {
                constraints.append(lhsDimension.constraint(greaterThanOrEqualTo: rhsDimension, multiplier: rhs.multiplier, constant: rhs.constant).withPriority(constraint.priority))
            } else if relation == .lessThanOrEqualTo {
                constraints.append(lhsDimension.constraint(lessThanOrEqualTo: rhsDimension, multiplier: rhs.multiplier, constant: rhs.constant).withPriority(constraint.priority))
            }
            
        }
        
        return constraints
    }
    
    public func clearConstraints() {
        NSLayoutConstraint.deactivate(currentConstraints)
        currentConstraints.removeAll()
    }
}
