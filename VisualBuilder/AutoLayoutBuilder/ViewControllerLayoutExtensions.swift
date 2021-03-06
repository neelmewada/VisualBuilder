//
//  ViewControllerExtensions.swift
//  VisualBuilder
//
//

import UIKit

// MARK: - VBLayoutBuilder

extension VBLayoutBuilder where Self: UIViewController {
    
    public func buildConstraints() {
        clearConstraints()
        
        var constraints = [NSLayoutConstraint]()
        
        for constraint in constraintBuilder {
            var constraintsToRemove = [NSLayoutConstraint]()
            
            // Check if this constraint is already active
            for currentlyActiveConstraint in currentConstraints {
                constraintsToRemove.append(currentlyActiveConstraint)
            }
            
            NSLayoutConstraint.deactivate(constraintsToRemove)
            currentConstraints.removeAll { x in
                return constraintsToRemove.contains(x)
            }
            
            constraints.append(contentsOf: createConstraints(constraint))
        }
        
        currentConstraints.append(contentsOf: constraints)
        NSLayoutConstraint.activate(currentConstraints)
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
        //currentConstraints.removeAll()
    }
}
