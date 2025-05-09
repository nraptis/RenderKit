//
//  RenderThemeGuideImplementing.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation

protocol RenderThemeGuideImplementing: RenderThemeImplementing {
    
    var g1_fillRegSelUnm: RGBA { get }
    var g2_fillRegSelUnm: RGBA { get }
    var g3_fillRegSelUnm: RGBA { get }
    var g4_fillRegSelUnm: RGBA { get }
    var g5_fillRegSelUnm: RGBA { get }

    var g1_fillRegUnsUnm: RGBA { get }
    var g2_fillRegUnsUnm: RGBA { get }
    var g3_fillRegUnsUnm: RGBA { get }
    var g4_fillRegUnsUnm: RGBA { get }
    var g5_fillRegUnsUnm: RGBA { get }
    
    var g1_fillRegSelMod: RGBA { get }
    var g2_fillRegSelMod: RGBA { get }
    var g3_fillRegSelMod: RGBA { get }
    var g4_fillRegSelMod: RGBA { get }
    var g5_fillRegSelMod: RGBA { get }

    var g1_fillRegUnsMod: RGBA { get }
    var g2_fillRegUnsMod: RGBA { get }
    var g3_fillRegUnsMod: RGBA { get }
    var g4_fillRegUnsMod: RGBA { get }
    var g5_fillRegUnsMod: RGBA { get }
    
    var g1_tanPointFillSel: RGBA { get }
    var g2_tanPointFillSel: RGBA { get }
    var g3_tanPointFillSel: RGBA { get }
    var g4_tanPointFillSel: RGBA { get }
    var g5_tanPointFillSel: RGBA { get }

    var g1_tanPointFillUns: RGBA { get }
    var g2_tanPointFillUns: RGBA { get }
    var g3_tanPointFillUns: RGBA { get }
    var g4_tanPointFillUns: RGBA { get }
    var g5_tanPointFillUns: RGBA { get }
}

extension RenderThemeGuideImplementing {
    
    func fillRegSelUnm(index: Int) -> RGBA {
        if index > 2 {
            if index > 3 {
                return g5_fillRegSelUnm // 5
            } else {
                return g4_fillRegSelUnm // 4
            }
        } else if index < 2 {
            if index > 0 {
                return g2_fillRegSelUnm // 2
            } else {
                return g1_fillRegSelUnm // 1
            }
        } else {
            return g3_fillRegSelUnm // 3
        }
    }

    func fillRegUnsUnm(index: Int) -> RGBA {
        if index > 2 {
            if index > 3 {
                return g5_fillRegUnsUnm // 5
            } else {
                return g4_fillRegUnsUnm // 4
            }
        } else if index < 2 {
            if index > 0 {
                return g2_fillRegUnsUnm // 2
            } else {
                return g1_fillRegUnsUnm // 1
            }
        } else {
            return g3_fillRegUnsUnm // 3
        }
    }
    
    func fillRegSelMod(index: Int) -> RGBA {
        if index > 2 {
            if index > 3 {
                return g5_fillRegSelMod // 5
            } else {
                return g4_fillRegSelMod // 4
            }
        } else if index < 2 {
            if index > 0 {
                return g2_fillRegSelMod // 2
            } else {
                return g1_fillRegSelMod // 1
            }
        } else {
            return g3_fillRegSelMod // 3
        }
    }

    func fillRegUnsMod(index: Int) -> RGBA {
        if index > 2 {
            if index > 3 {
                return g5_fillRegUnsMod // 5
            } else {
                return g4_fillRegUnsMod // 4
            }
        } else if index < 2 {
            if index > 0 {
                return g2_fillRegUnsMod // 2
            } else {
                return g1_fillRegUnsMod // 1
            }
        } else {
            return g3_fillRegUnsMod // 3
        }
    }
    
    func tanPointFillSel(index: Int) -> RGBA {
        if index > 2 {
            if index > 3 {
                return g5_tanPointFillSel // 5
            } else {
                return g4_tanPointFillSel // 4
            }
        } else if index < 2 {
            if index > 0 {
                return g2_tanPointFillSel // 2
            } else {
                return g1_tanPointFillSel // 1
            }
        } else {
            return g3_tanPointFillSel // 3
        }
    }

    func tanPointFillUns(index: Int) -> RGBA {
        if index > 2 {
            if index > 3 {
                return g5_tanPointFillUns // 5
            } else {
                return g4_tanPointFillUns // 4
            }
        } else if index < 2 {
            if index > 0 {
                return g2_tanPointFillUns // 2
            } else {
                return g1_tanPointFillUns // 1
            }
        } else {
            return g3_tanPointFillUns // 3
        }
    }
    
}
