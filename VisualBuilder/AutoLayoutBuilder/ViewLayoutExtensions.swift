//
//  ViewExtensions.swift
//  VisualBuilder
//
//  Created by Neel Mewada on 24/05/21.
//

import UIKit




// MARK: - Anchor Extensions

extension UIView {
    
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
