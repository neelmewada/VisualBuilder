//
//  VBHierarchyBuilder.swift
//  VisualBuilder
//
//  Created by Neel Mewada on 24/05/21.
//

import UIKit

@resultBuilder public struct ViewHierarchyBuilder {
    
    public static func buildBlock(_ components: Any...) -> [Any] {
        return components
    }
    
}

public protocol VBHierarchyBuilder: NSObject {
    var currentHierarchy: [Any] { get set }
    var hierarchyBuilder: [Any] { get }
    func buildHierarchy()
}


