//
//  RenderThemeImplementing.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import UIKit

public protocol RenderThemeJiggleImplementing: RenderThemeImplementing {
    
    var centerMarkerUnselectedActive: RGBA { get }
    
    var strokeRegSel: RGBA { get }
    var strokeRegUns: RGBA { get }
    var strokeAltSel: RGBA { get }
    var strokeAltUns: RGBA { get }
    var strokeDis: RGBA { get }
    
    var fillRegSelUnm: RGBA { get }
    var fillRegSelMod: RGBA { get }
    var fillRegUnsUnm: RGBA { get }
    var fillRegUnsMod: RGBA { get }
    var fillAltSelUnm: RGBA { get }
    var fillAltSelMod: RGBA { get }
    var fillAltUnsUnm: RGBA { get }
    var fillAltUnsMod: RGBA { get }
    var fillDis: RGBA { get }
    var fillGrb: RGBA { get }
    
    var tanPointFillSel: RGBA { get }
    var tanPointFillUns: RGBA { get }
}

