//
//  RenderThemeImplementing.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import UIKit

public protocol RenderThemeImplementing {
    
}

extension RenderThemeImplementing {

    static func loadRGBA(colorName: String, colorNamePostfix: String) -> RGBA {
        
        let _colorName = colorName + colorNamePostfix
        let uiColor: UIColor
        if let _uiColor = UIColor(named: _colorName) {
            uiColor = _uiColor
        } else {
            uiColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        return RGBA(uiColor: uiColor)
    }
    
}

struct AnyRenderTheme: RenderThemeImplementing {
    
}
