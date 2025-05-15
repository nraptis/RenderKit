//
//  RT.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation
import UIKit

public struct RTJ {
    
    nonisolated(unsafe) public static let D = RenderThemeJiggleDark()
    nonisolated(unsafe) public static let L = RenderThemeJiggleLight()
    
    // Bloom
    public static func bloom(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.bloom : L.bloom
    }
    
    // Center Marker
    public static func centerMarkerUnselectedActive(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.centerMarkerUnselectedActive : L.centerMarkerUnselectedActive
    }
    
    // Stroke Colors
    public static func strokeRegSel(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeRegSel : L.strokeRegSel
    }
    
    public static func strokeRegUns(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeRegUns : L.strokeRegUns
    }
    
    public static func strokeAltSel(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeAltSel : L.strokeAltSel
    }
    
    public static func strokeAltUns(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeAltUns : L.strokeAltUns
    }
    
    public static func strokeDis(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.strokeDis : L.strokeDis
    }
    
    // Fill Colors
    public static func fillRegSelUnm(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegSelUnm : L.fillRegSelUnm
    }
    
    public static func fillRegSelMod(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegSelMod : L.fillRegSelMod
    }
    
    public static func fillRegUnsUnm(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegUnsUnm : L.fillRegUnsUnm
    }
    
    public static func fillRegUnsMod(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillRegUnsMod : L.fillRegUnsMod
    }
    
    public static func fillAltSelUnm(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillAltSelUnm : L.fillAltSelUnm
    }
    
    public static func fillAltSelMod(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillAltSelMod : L.fillAltSelMod
    }
    
    public static func fillAltUnsUnm(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillAltUnsUnm : L.fillAltUnsUnm
    }
    
    public static func fillAltUnsMod(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillAltUnsMod : L.fillAltUnsMod
    }
    
    public static func fillDis(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillDis : L.fillDis
    }
    
    public static func fillGrb(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.fillGrb : L.fillGrb
    }
    
    // Tan Point Colors
    public static func tanPointFillSel(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.tanPointFillSel : L.tanPointFillSel
    }
    
    public static func tanPointFillUns(isDarkMode: Bool) -> RGBA {
        isDarkMode ? D.tanPointFillUns : L.tanPointFillUns
    }
    
    static let _jiggleFillDarkFrozen = UIColor(named: "jiggle_fill_dark_frozen") ?? UIColor()
    static let _jiggleFillDark0 = UIColor(named: "jiggle_fill_dark_0") ?? UIColor()
    static let _jiggleFillDark1 = UIColor(named: "jiggle_fill_dark_1") ?? UIColor()
    static let _jiggleFillDark2 = UIColor(named: "jiggle_fill_dark_2") ?? UIColor()
    static let _jiggleFillDark3 = UIColor(named: "jiggle_fill_dark_3") ?? UIColor()
    static let _jiggleFillDark4 = UIColor(named: "jiggle_fill_dark_4") ?? UIColor()
    static let _jiggleFillDark5 = UIColor(named: "jiggle_fill_dark_5") ?? UIColor()
    static let _jiggleFillDark6 = UIColor(named: "jiggle_fill_dark_6") ?? UIColor()
    
    static let _jiggleFillLightFrozen = UIColor(named: "jiggle_fill_light_frozen") ?? UIColor()
    static let _jiggleFillLight0 = UIColor(named: "jiggle_fill_light_0") ?? UIColor()
    static let _jiggleFillLight1 = UIColor(named: "jiggle_fill_light_1") ?? UIColor()
    static let _jiggleFillLight2 = UIColor(named: "jiggle_fill_light_2") ?? UIColor()
    static let _jiggleFillLight3 = UIColor(named: "jiggle_fill_light_3") ?? UIColor()
    static let _jiggleFillLight4 = UIColor(named: "jiggle_fill_light_4") ?? UIColor()
    static let _jiggleFillLight5 = UIColor(named: "jiggle_fill_light_5") ?? UIColor()
    static let _jiggleFillLight6 = UIColor(named: "jiggle_fill_light_6") ?? UIColor()
    
    public static let jiggleFillDarkFrozen = RGBA(uiColor: _jiggleFillDarkFrozen)
    public static let jiggleFillDark0 = RGBA(uiColor: _jiggleFillDark0)
    static let jiggleFillDark1 = RGBA(uiColor: _jiggleFillDark1)
    static let jiggleFillDark2 = RGBA(uiColor: _jiggleFillDark2)
    static let jiggleFillDark3 = RGBA(uiColor: _jiggleFillDark3)
    static let jiggleFillDark4 = RGBA(uiColor: _jiggleFillDark4)
    static let jiggleFillDark5 = RGBA(uiColor: _jiggleFillDark5)
    static let jiggleFillDark6 = RGBA(uiColor: _jiggleFillDark6)
    
    public static let jiggleFillLightFrozen = RGBA(uiColor: _jiggleFillLightFrozen)
    public static let jiggleFillLight0 = RGBA(uiColor: _jiggleFillLight0)
    static let jiggleFillLight1 = RGBA(uiColor: _jiggleFillLight1)
    static let jiggleFillLight2 = RGBA(uiColor: _jiggleFillLight2)
    static let jiggleFillLight3 = RGBA(uiColor: _jiggleFillLight3)
    static let jiggleFillLight4 = RGBA(uiColor: _jiggleFillLight4)
    static let jiggleFillLight5 = RGBA(uiColor: _jiggleFillLight5)
    static let jiggleFillLight6 = RGBA(uiColor: _jiggleFillLight6)
    
    static let fillRedDark: [Float] = [ Self.jiggleFillDark0.red, Self.jiggleFillDark1.red, Self.jiggleFillDark2.red, Self.jiggleFillDark3.red, Self.jiggleFillDark4.red, Self.jiggleFillDark5.red, Self.jiggleFillDark6.red]
    static let fillGreenDark: [Float] = [ Self.jiggleFillDark0.green, Self.jiggleFillDark1.green, Self.jiggleFillDark2.green, Self.jiggleFillDark3.green, Self.jiggleFillDark4.green, Self.jiggleFillDark5.green, Self.jiggleFillDark6.green]
    static let fillBlueDark: [Float] = [ Self.jiggleFillDark0.blue, Self.jiggleFillDark1.blue, Self.jiggleFillDark2.blue, Self.jiggleFillDark3.blue, Self.jiggleFillDark4.blue, Self.jiggleFillDark5.blue, Self.jiggleFillDark6.blue]
    
    static let fillRedLight: [Float] = [ Self.jiggleFillLight0.red, Self.jiggleFillLight1.red, Self.jiggleFillLight2.red, Self.jiggleFillLight3.red, Self.jiggleFillLight4.red, Self.jiggleFillLight5.red, Self.jiggleFillLight6.red]
    static let fillGreenLight: [Float] = [ Self.jiggleFillLight0.green, Self.jiggleFillLight1.green, Self.jiggleFillLight2.green, Self.jiggleFillLight3.green, Self.jiggleFillLight4.green, Self.jiggleFillLight5.green, Self.jiggleFillLight6.green]
    static let fillBlueLight: [Float] = [ Self.jiggleFillLight0.blue, Self.jiggleFillLight1.blue, Self.jiggleFillLight2.blue, Self.jiggleFillLight3.blue, Self.jiggleFillLight4.blue, Self.jiggleFillLight5.blue, Self.jiggleFillLight6.blue]
    
    private static func GET_INTERP(_ p: Float) -> ColorInterp {
        if p < 0.16666667 {
            var p = p
            if p < 0.0 { p = 0.0 }
            return ColorInterp(index1: 0,
                               index2: 1,
                               blend: p / 0.16666667)
        } else if p < 0.33333333 {
            return ColorInterp(index1: 1,
                               index2: 2,
                               blend: (p - 0.16666667) / (0.33333333 - 0.16666667))
        } else if p < 0.5 {
            return ColorInterp(index1: 2,
                               index2: 3,
                               blend: (p - 0.33333333) / (0.5 - 0.33333333))
        } else if p < 0.66666667 {
            return ColorInterp(index1: 3,
                               index2: 4,
                               blend: (p - 0.5) / (0.66666667 - 0.5))
        } else if p < 0.83333333 {
            return ColorInterp(index1: 4,
                               index2: 5,
                               blend: (p - 0.66666667) / (0.83333333 - 0.66666667))
        } else {
            var p = p
            if p > 1.0 { p = 1.0 }
            return ColorInterp(index1: 5,
                               index2: 6,
                               blend: (p - 0.83333333) / (1.0 - 0.83333333))
        }
    }
    
    static func getFill(percent: Float, array: [Float]) -> Float {
        let INTERP = Self.GET_INTERP(percent)
        return array[INTERP.index1] + (array[INTERP.index2] - array[INTERP.index1]) * INTERP.blend
    }
    
    public static func getFillRedDark(level: Int, ceiling: Int, percent: Float) -> Float {
        if ceiling == 1 {
            return getFill(percent: percent, array: fillRedDark)
        } else if ceiling == 2 {
            if level == 0 {
                return getFill(percent: (percent * 0.5), array: fillRedDark)
            } else {
                return getFill(percent: 0.5 + (percent * 0.5), array: fillRedDark)
            }
        } else if ceiling == 3 {
            if level == 0 {
                return getFill(percent: (percent * 0.33333333), array: fillRedDark)
            } else if level == 1 {
                return getFill(percent: 0.33333333 + (percent * 0.33333333), array: fillRedDark)
            } else {
                return getFill(percent: 0.6666667 + (percent * 0.33333333), array: fillRedDark)
            }
        } else if ceiling == 4 {
            if level == 0 {
                return getFill(percent: (percent * 0.25), array: fillRedDark)
            } else if level == 1 {
                return getFill(percent: 0.25 + (percent * 0.25), array: fillRedDark)
            } else if level == 2 {
                return getFill(percent: 0.5 + (percent * 0.25), array: fillRedDark)
            } else {
                return getFill(percent: 0.75 + (percent * 0.25), array: fillRedDark)
            }
        } else if ceiling == 5 {
            if level == 0 {
                return getFill(percent: (percent * 0.2), array: fillRedDark)
            } else if level == 1 {
                return getFill(percent: 0.2 + (percent * 0.2), array: fillRedDark)
            } else if level == 2 {
                return getFill(percent: 0.4 + (percent * 0.2), array: fillRedDark)
            } else if level == 3 {
                return getFill(percent: 0.6 + (percent * 0.2), array: fillRedDark)
            } else {
                return getFill(percent: 0.8 + (percent * 0.2), array: fillRedDark)
            }
        } else {
            if level == 0 {
                return getFill(percent: (percent * 0.16666667), array: fillRedDark)
            } else if level == 1 {
                return getFill(percent: 0.16666667 + (percent * 0.16666667), array: fillRedDark)
            } else if level == 2 {
                return getFill(percent: 0.33333333 + (percent * 0.16666667), array: fillRedDark)
            } else if level == 3 {
                return getFill(percent: 0.5 + (percent * 0.16666667), array: fillRedDark)
            } else if level == 4 {
                return getFill(percent: 0.66666667 + (percent * 0.16666667), array: fillRedDark)
            } else {
                return getFill(percent: 0.83333333 + (percent * 0.16666667), array: fillRedDark)
            }
        }
    }
    
    public static func getFillGreenDark(level: Int, ceiling: Int, percent: Float) -> Float {
        if ceiling == 1 {
            return getFill(percent: percent, array: fillGreenDark)
        } else if ceiling == 2 {
            if level == 0 {
                return getFill(percent: (percent * 0.5), array: fillGreenDark)
            } else {
                return getFill(percent: 0.5 + (percent * 0.5), array: fillGreenDark)
            }
        } else if ceiling == 3 {
            if level == 0 {
                return getFill(percent: (percent * 0.33333333), array: fillGreenDark)
            } else if level == 1 {
                return getFill(percent: 0.33333333 + (percent * 0.33333333), array: fillGreenDark)
            } else {
                return getFill(percent: 0.6666667 + (percent * 0.33333333), array: fillGreenDark)
            }
        } else if ceiling == 4 {
            if level == 0 {
                return getFill(percent: (percent * 0.25), array: fillGreenDark)
            } else if level == 1 {
                return getFill(percent: 0.25 + (percent * 0.25), array: fillGreenDark)
            } else if level == 2 {
                return getFill(percent: 0.5 + (percent * 0.25), array: fillGreenDark)
            } else {
                return getFill(percent: 0.75 + (percent * 0.25), array: fillGreenDark)
            }
        } else if ceiling == 5 {
            if level == 0 {
                return getFill(percent: (percent * 0.2), array: fillGreenDark)
            } else if level == 1 {
                return getFill(percent: 0.2 + (percent * 0.2), array: fillGreenDark)
            } else if level == 2 {
                return getFill(percent: 0.4 + (percent * 0.2), array: fillGreenDark)
            } else if level == 3 {
                return getFill(percent: 0.6 + (percent * 0.2), array: fillGreenDark)
            } else {
                return getFill(percent: 0.8 + (percent * 0.2), array: fillGreenDark)
            }
        } else {
            if level == 0 {
                return getFill(percent: (percent * 0.16666667), array: fillGreenDark)
            } else if level == 1 {
                return getFill(percent: 0.16666667 + (percent * 0.16666667), array: fillGreenDark)
            } else if level == 2 {
                return getFill(percent: 0.33333333 + (percent * 0.16666667), array: fillGreenDark)
            } else if level == 3 {
                return getFill(percent: 0.5 + (percent * 0.16666667), array: fillGreenDark)
            } else if level == 4 {
                return getFill(percent: 0.66666667 + (percent * 0.16666667), array: fillGreenDark)
            } else {
                return getFill(percent: 0.83333333 + (percent * 0.16666667), array: fillGreenDark)
            }
        }
    }
    
    public static func getFillBlueDark(level: Int, ceiling: Int, percent: Float) -> Float {
        if ceiling == 1 {
            return getFill(percent: percent, array: fillBlueDark)
        } else if ceiling == 2 {
            if level == 0 {
                return getFill(percent: (percent * 0.5), array: fillBlueDark)
            } else {
                return getFill(percent: 0.5 + (percent * 0.5), array: fillBlueDark)
            }
        } else if ceiling == 3 {
            if level == 0 {
                return getFill(percent: (percent * 0.33333333), array: fillBlueDark)
            } else if level == 1 {
                return getFill(percent: 0.33333333 + (percent * 0.33333333), array: fillBlueDark)
            } else {
                return getFill(percent: 0.6666667 + (percent * 0.33333333), array: fillBlueDark)
            }
        } else if ceiling == 4 {
            if level == 0 {
                return getFill(percent: (percent * 0.25), array: fillBlueDark)
            } else if level == 1 {
                return getFill(percent: 0.25 + (percent * 0.25), array: fillBlueDark)
            } else if level == 2 {
                return getFill(percent: 0.5 + (percent * 0.25), array: fillBlueDark)
            } else {
                return getFill(percent: 0.75 + (percent * 0.25), array: fillBlueDark)
            }
        } else if ceiling == 5 {
            if level == 0 {
                return getFill(percent: (percent * 0.2), array: fillBlueDark)
            } else if level == 1 {
                return getFill(percent: 0.2 + (percent * 0.2), array: fillBlueDark)
            } else if level == 2 {
                return getFill(percent: 0.4 + (percent * 0.2), array: fillBlueDark)
            } else if level == 3 {
                return getFill(percent: 0.6 + (percent * 0.2), array: fillBlueDark)
            } else {
                return getFill(percent: 0.8 + (percent * 0.2), array: fillBlueDark)
            }
        } else {
            if level == 0 {
                return getFill(percent: (percent * 0.16666667), array: fillBlueDark)
            } else if level == 1 {
                return getFill(percent: 0.16666667 + (percent * 0.16666667), array: fillBlueDark)
            } else if level == 2 {
                return getFill(percent: 0.33333333 + (percent * 0.16666667), array: fillBlueDark)
            } else if level == 3 {
                return getFill(percent: 0.5 + (percent * 0.16666667), array: fillBlueDark)
            } else if level == 4 {
                return getFill(percent: 0.66666667 + (percent * 0.16666667), array: fillBlueDark)
            } else {
                return getFill(percent: 0.83333333 + (percent * 0.16666667), array: fillBlueDark)
            }
        }
    }
    
    public static func getFillRedLight(level: Int, ceiling: Int, percent: Float) -> Float {
        if ceiling == 1 {
            return getFill(percent: percent, array: fillRedLight)
        } else if ceiling == 2 {
            if level == 0 {
                return getFill(percent: (percent * 0.5), array: fillRedLight)
            } else {
                return getFill(percent: 0.5 + (percent * 0.5), array: fillRedLight)
            }
        } else if ceiling == 3 {
            if level == 0 {
                return getFill(percent: (percent * 0.33333333), array: fillRedLight)
            } else if level == 1 {
                return getFill(percent: 0.33333333 + (percent * 0.33333333), array: fillRedLight)
            } else {
                return getFill(percent: 0.6666667 + (percent * 0.33333333), array: fillRedLight)
            }
        } else if ceiling == 4 {
            if level == 0 {
                return getFill(percent: (percent * 0.25), array: fillRedLight)
            } else if level == 1 {
                return getFill(percent: 0.25 + (percent * 0.25), array: fillRedLight)
            } else if level == 2 {
                return getFill(percent: 0.5 + (percent * 0.25), array: fillRedLight)
            } else {
                return getFill(percent: 0.75 + (percent * 0.25), array: fillRedLight)
            }
        } else if ceiling == 5 {
            if level == 0 {
                return getFill(percent: (percent * 0.2), array: fillRedLight)
            } else if level == 1 {
                return getFill(percent: 0.2 + (percent * 0.2), array: fillRedLight)
            } else if level == 2 {
                return getFill(percent: 0.4 + (percent * 0.2), array: fillRedLight)
            } else if level == 3 {
                return getFill(percent: 0.6 + (percent * 0.2), array: fillRedLight)
            } else {
                return getFill(percent: 0.8 + (percent * 0.2), array: fillRedLight)
            }
        } else {
            if level == 0 {
                return getFill(percent: (percent * 0.16666667), array: fillRedLight)
            } else if level == 1 {
                return getFill(percent: 0.16666667 + (percent * 0.16666667), array: fillRedLight)
            } else if level == 2 {
                return getFill(percent: 0.33333333 + (percent * 0.16666667), array: fillRedLight)
            } else if level == 3 {
                return getFill(percent: 0.5 + (percent * 0.16666667), array: fillRedLight)
            } else if level == 4 {
                return getFill(percent: 0.66666667 + (percent * 0.16666667), array: fillRedLight)
            } else {
                return getFill(percent: 0.83333333 + (percent * 0.16666667), array: fillRedLight)
            }
        }
    }
    
    public static func getFillGreenLight(level: Int, ceiling: Int, percent: Float) -> Float {
        if ceiling == 1 {
            return getFill(percent: percent, array: fillGreenLight)
        } else if ceiling == 2 {
            if level == 0 {
                return getFill(percent: (percent * 0.5), array: fillGreenLight)
            } else {
                return getFill(percent: 0.5 + (percent * 0.5), array: fillGreenLight)
            }
        } else if ceiling == 3 {
            if level == 0 {
                return getFill(percent: (percent * 0.33333333), array: fillGreenLight)
            } else if level == 1 {
                return getFill(percent: 0.33333333 + (percent * 0.33333333), array: fillGreenLight)
            } else {
                return getFill(percent: 0.6666667 + (percent * 0.33333333), array: fillGreenLight)
            }
        } else if ceiling == 4 {
            if level == 0 {
                return getFill(percent: (percent * 0.25), array: fillGreenLight)
            } else if level == 1 {
                return getFill(percent: 0.25 + (percent * 0.25), array: fillGreenLight)
            } else if level == 2 {
                return getFill(percent: 0.5 + (percent * 0.25), array: fillGreenLight)
            } else {
                return getFill(percent: 0.75 + (percent * 0.25), array: fillGreenLight)
            }
        } else if ceiling == 5 {
            if level == 0 {
                return getFill(percent: (percent * 0.2), array: fillGreenLight)
            } else if level == 1 {
                return getFill(percent: 0.2 + (percent * 0.2), array: fillGreenLight)
            } else if level == 2 {
                return getFill(percent: 0.4 + (percent * 0.2), array: fillGreenLight)
            } else if level == 3 {
                return getFill(percent: 0.6 + (percent * 0.2), array: fillGreenLight)
            } else {
                return getFill(percent: 0.8 + (percent * 0.2), array: fillGreenLight)
            }
        } else {
            if level == 0 {
                return getFill(percent: (percent * 0.16666667), array: fillGreenLight)
            } else if level == 1 {
                return getFill(percent: 0.16666667 + (percent * 0.16666667), array: fillGreenLight)
            } else if level == 2 {
                return getFill(percent: 0.33333333 + (percent * 0.16666667), array: fillGreenLight)
            } else if level == 3 {
                return getFill(percent: 0.5 + (percent * 0.16666667), array: fillGreenLight)
            } else if level == 4 {
                return getFill(percent: 0.66666667 + (percent * 0.16666667), array: fillGreenLight)
            } else {
                return getFill(percent: 0.83333333 + (percent * 0.16666667), array: fillGreenLight)
            }
        }
    }
    
    public static func getFillBlueLight(level: Int, ceiling: Int, percent: Float) -> Float {
        if ceiling == 1 {
            return getFill(percent: percent, array: fillBlueLight)
        } else if ceiling == 2 {
            if level == 0 {
                return getFill(percent: (percent * 0.5), array: fillBlueLight)
            } else {
                return getFill(percent: 0.5 + (percent * 0.5), array: fillBlueLight)
            }
        } else if ceiling == 3 {
            if level == 0 {
                return getFill(percent: (percent * 0.33333333), array: fillBlueLight)
            } else if level == 1 {
                return getFill(percent: 0.33333333 + (percent * 0.33333333), array: fillBlueLight)
            } else {
                return getFill(percent: 0.6666667 + (percent * 0.33333333), array: fillBlueLight)
            }
        } else if ceiling == 4 {
            if level == 0 {
                return getFill(percent: (percent * 0.25), array: fillBlueLight)
            } else if level == 1 {
                return getFill(percent: 0.25 + (percent * 0.25), array: fillBlueLight)
            } else if level == 2 {
                return getFill(percent: 0.5 + (percent * 0.25), array: fillBlueLight)
            } else {
                return getFill(percent: 0.75 + (percent * 0.25), array: fillBlueLight)
            }
        } else if ceiling == 5 {
            if level == 0 {
                return getFill(percent: (percent * 0.2), array: fillBlueLight)
            } else if level == 1 {
                return getFill(percent: 0.2 + (percent * 0.2), array: fillBlueLight)
            } else if level == 2 {
                return getFill(percent: 0.4 + (percent * 0.2), array: fillBlueLight)
            } else if level == 3 {
                return getFill(percent: 0.6 + (percent * 0.2), array: fillBlueLight)
            } else {
                return getFill(percent: 0.8 + (percent * 0.2), array: fillBlueLight)
            }
        } else {
            if level == 0 {
                return getFill(percent: (percent * 0.16666667), array: fillBlueLight)
            } else if level == 1 {
                return getFill(percent: 0.16666667 + (percent * 0.16666667), array: fillBlueLight)
            } else if level == 2 {
                return getFill(percent: 0.33333333 + (percent * 0.16666667), array: fillBlueLight)
            } else if level == 3 {
                return getFill(percent: 0.5 + (percent * 0.16666667), array: fillBlueLight)
            } else if level == 4 {
                return getFill(percent: 0.66666667 + (percent * 0.16666667), array: fillBlueLight)
            } else {
                return getFill(percent: 0.83333333 + (percent * 0.16666667), array: fillBlueLight)
            }
        }
    }
}
