//
//  LinePointSize.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/12/25.
//

import Foundation
import TypeKit

public struct LinePointSizes {
    
    public nonisolated(unsafe) static var userPointSizeType = RenderPointSizeType.b
    public nonisolated(unsafe) static var userLineThicknessType = RenderLineThicknessType.c
    
    static func getSelectedPointExpansion(lineThicknessType: RenderLineThicknessType,
                                          pointSizeType: RenderPointSizeType,
                                          isPad: Bool) -> Int {
        
        let isBigLine: Bool
        switch lineThicknessType {
        case .a, .b:
            isBigLine = false
        default:
            isBigLine = true
        }
        
        let isBigPoint: Bool
        switch pointSizeType {
        case .a, .b:
            isBigPoint = false
        default:
            isBigPoint = true
        }
        
        if isPad {
            if isBigLine {
                if isBigPoint {
                    return 4
                } else {
                    return 2
                }
            } else {
                if isBigPoint {
                    return 2
                } else {
                    return 2
                }
            }
        } else {
            if isBigLine {
                if isBigPoint {
                    return 4
                } else {
                    return 2
                }
            } else {
                if isBigPoint {
                    return 2
                } else {
                    return 2
                }
            }
        }
    }
    
    public static func getPointFillBase(lineThicknessType: RenderLineThicknessType,
                                 pointSizeType: RenderPointSizeType,
                                 isSelected: Bool,
                                 isPad: Bool) -> Int {
        
        let expand: Int
        if isSelected {
            expand = getSelectedPointExpansion(lineThicknessType: lineThicknessType,
                                               pointSizeType: pointSizeType,
                                               isPad: isPad)
        } else {
            expand = 0
        }
        
        if isPad {
            
            switch lineThicknessType {
            case .a:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 4 + expand, step: 2)
            case .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 4 + expand, step: 2)
            case .c:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 6 + expand, step: 2)
            case .d:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 6 + expand, step: 2)
            }
            
        } else {
            
            switch lineThicknessType {
            case .a:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 3 + expand, step: 2)
            case .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 3 + expand, step: 2)
            case .c:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 5 + expand, step: 2)
            case .d:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 5 + expand, step: 2)
            }
        }
    }
    
    public static func getLineBase(lineThicknessType: RenderLineThicknessType,
                            isPad: Bool) -> Int {
        if isPad {
            // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
            return lineThicknessType.process(start: 3, step: 1)
        } else {
            // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
            return lineThicknessType.process(start: 4, step: 2)
        }
    }
    
    static func getLineStrokeExpandBase(lineThicknessType: RenderLineThicknessType,
                                        isPad: Bool) -> Int {
        if isPad {
            switch lineThicknessType {
            case .a, .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 3
            default:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 5
            }
        } else {
            switch lineThicknessType {
            case .a, .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 6
            default:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 10
            }
        }
    }
    
    static func getPointStrokeExpandBase(lineThicknessType: RenderLineThicknessType,
                                         pointSizeType: RenderPointSizeType,
                                         isSelected: Bool,
                                         isPad: Bool) -> Int {
        if isPad {
            switch lineThicknessType {
            case .a, .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 2
            default:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 4
            }
        } else {
            switch lineThicknessType {
            case .a, .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 2
            default:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 4
            }
        }
    }
    
    public static func getPointStrokeBase(lineThicknessType: RenderLineThicknessType,
                                   pointSizeType: RenderPointSizeType,
                                   isSelected: Bool,
                                   isPad: Bool) -> Int {
        // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
        let fillBase = getPointFillBase(lineThicknessType: lineThicknessType,
                                        pointSizeType: pointSizeType,
                                        isSelected: isSelected,
                                        isPad: isPad)
        let strokeExpand = getPointStrokeExpandBase(lineThicknessType: lineThicknessType,
                                                    pointSizeType: pointSizeType,
                                                    isSelected: isSelected,
                                                    isPad: isPad)
        return fillBase + strokeExpand
    }
    
    public static func getLineThicknessFill(lineThicknessType: RenderLineThicknessType,
                                            isPad: Bool,
                                            universeScaleInverse: Float) -> Float {
        // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
        let baseAmount = getLineBase(lineThicknessType: lineThicknessType,
                                     isPad: isPad)
        return Float(baseAmount) * universeScaleInverse
    }
    
    public static func getLineThicknessStroke(lineThicknessType: RenderLineThicknessType,
                                              isPad: Bool,
                                              universeScaleInverse: Float) -> Float {
        // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
        let baseAmount = getLineBase(lineThicknessType: lineThicknessType,
                                     isPad: isPad)
        let strokeExpand = getLineStrokeExpandBase(lineThicknessType: lineThicknessType,
                                                   isPad: isPad)
        return Float(baseAmount + strokeExpand + strokeExpand) * universeScaleInverse
    }
    
    public static func getLineThicknessDrawingFill(lineThicknessType: RenderLineThicknessType,
                                                   isPad: Bool,
                                                   universeScaleInverse: Float) -> Float {
        // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
        let baseAmount = getLineBase(lineThicknessType: lineThicknessType,
                                     isPad: isPad) + 2
        return Float(baseAmount) * universeScaleInverse
    }
    
    public static func getLineThicknessDrawingStroke(lineThicknessType: RenderLineThicknessType,
                                                     isPad: Bool,
                                                     universeScaleInverse: Float) -> Float {
        // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
        let baseAmount = getLineBase(lineThicknessType: lineThicknessType,
                                     isPad: isPad) + 2
        let strokeExpand = getLineStrokeExpandBase(lineThicknessType: lineThicknessType,
                                                   isPad: isPad)
        return Float(baseAmount + strokeExpand) * universeScaleInverse
    }
}
