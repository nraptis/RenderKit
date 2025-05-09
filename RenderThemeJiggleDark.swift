//
//  RenderThemeDark.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation

public struct RenderThemeJiggleDark: RenderThemeJiggleImplementing {
    
    public let bloom: RGBA
    
    public let centerMarkerUnselectedActive: RGBA
    
    public let strokeRegSel: RGBA
    public let strokeRegUns: RGBA
    public let strokeAltSel: RGBA
    public let strokeAltUns: RGBA
    public let strokeDis: RGBA
    
    public let fillRegSelUnm: RGBA
    public let fillRegSelMod: RGBA
    public let fillRegUnsUnm: RGBA
    public let fillRegUnsMod: RGBA
    public let fillAltSelUnm: RGBA
    public let fillAltSelMod: RGBA
    public let fillAltUnsUnm: RGBA
    public let fillAltUnsMod: RGBA
    public let fillDis: RGBA
    public let fillGrb: RGBA
    public let tanPointFillSel: RGBA
    public let tanPointFillUns: RGBA

    public init() {
        let colors = RenderThemeJiggleColorPack(colorNamePostfix: "_drk")
        self.bloom = colors.bloom
        self.centerMarkerUnselectedActive = colors.centerMarkerUnselectedActive
        self.strokeRegSel = colors.strokeRegSel
        self.strokeRegUns = colors.strokeRegUns
        self.strokeAltSel = colors.strokeAltSel
        self.strokeAltUns = colors.strokeAltUns
        self.strokeDis = colors.strokeDis
        self.fillRegSelUnm = colors.fillRegSelUnm
        self.fillRegSelMod = colors.fillRegSelMod
        self.fillRegUnsUnm = colors.fillRegUnsUnm
        self.fillRegUnsMod = colors.fillRegUnsMod
        self.fillAltSelUnm = colors.fillAltSelUnm
        self.fillAltSelMod = colors.fillAltSelMod
        self.fillAltUnsUnm = colors.fillAltUnsUnm
        self.fillAltUnsMod = colors.fillAltUnsMod
        self.fillDis = colors.fillDis
        self.fillGrb = colors.fillGrb
        self.tanPointFillSel = colors.tanPointFillSel
        self.tanPointFillUns = colors.tanPointFillUns
    }
}
