//
//  JiggleRenderer+JigglePoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/23/24.
//

import Foundation
import Metal
import simd
import MathKit
import TypeKit

extension JiggleRenderer {
    
    public func getPointsCreatorModeFormat(creatorMode: CreatorMode) -> PointsCreatorModeFormat {
        let creatorModeFormat: PointsCreatorModeFormat
        switch creatorMode {
        case .none:
            switch pointSelectionMode {
            case .tans:
                creatorModeFormat = .alternative
            default:
                creatorModeFormat = .regular
            }
        case .makeJiggle:
            creatorModeFormat = .invalid
        case .drawJiggle:
            creatorModeFormat = .invalid
        case .addJigglePoint:
            if isJiggleSelected {
                creatorModeFormat = .regular
            } else {
                creatorModeFormat = .alternative
            }
        case .removeJigglePoint:
            creatorModeFormat = .regular
        case .makeGuide:
            creatorModeFormat = .invalid
        case .drawGuide:
            creatorModeFormat = .invalid
        case .addGuidePoint:
            creatorModeFormat = .invalid
        case .removeGuidePoint:
            creatorModeFormat = .invalid
        case .moveJiggleCenter:
            creatorModeFormat = .alternative
        case .moveGuideCenter:
            creatorModeFormat = .alternative
        }
        return creatorModeFormat
    }
    
    // This is mainly just to compute the colors...
    // We only do it *ONCE* for both Precise and Regular...
    public func pre_preparePoints(renderInfo: JiggleRenderInfo) {
        
        guard renderInfo.isShowingJigglePoints else { return }
        
        if isJiggleFrozen {
            color_points_unmodified_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_points_unmodified_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            color_points_modified_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_points_modified_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            return
        }
        
        switch pointsCreatorModeFormat {
        case .regular, .invalid:
            if isJiggleSelected {
                color_points_unmodified_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTJ.fillRegSelUnm(isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTJ.fillRegSelMod(isDarkMode: isDarkMode)
                color_points_selected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_selected_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
                
                color_points_unmodified_tanselected_fill = RTJ.fillRegSelUnm(isDarkMode: isDarkMode)
                color_points_modified_tanselected_fill = RTJ.fillRegSelMod(isDarkMode: isDarkMode)
                
                
            } else {
                color_points_unmodified_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTJ.fillRegUnsUnm(isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTJ.fillRegUnsMod(isDarkMode: isDarkMode)
            }
        case .alternative:
            if isJiggleSelected {
                color_points_unmodified_unselected_stroke = RTJ.strokeAltSel(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTJ.fillAltSelUnm(isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeAltSel(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTJ.fillAltSelMod(isDarkMode: isDarkMode)
                color_points_selected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_points_selected_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
                
                color_points_unmodified_tanselected_fill = RTJ.fillRegSelUnm(isDarkMode: isDarkMode)
                color_points_modified_tanselected_fill = RTJ.fillRegSelMod(isDarkMode: isDarkMode)
            } else {
                color_points_unmodified_unselected_stroke = RTJ.strokeAltUns(isDarkMode: isDarkMode)
                color_points_unmodified_unselected_fill = RTJ.fillAltUnsUnm(isDarkMode: isDarkMode)
                color_points_modified_unselected_stroke = RTJ.strokeAltUns(isDarkMode: isDarkMode)
                color_points_modified_unselected_fill = RTJ.fillAltUnsMod(isDarkMode: isDarkMode)
            }
        }
    }
    
    public func preparePoints(renderInfo: JiggleRenderInfo,
                       
                       jiggleControlPoints: [some RenderControlPoint],
                       jiggleControlPointCount: Int,
                       
                       pointsUnselectedBloomBuffer: IndexedSpriteBuffer3D,
                       pointsUnselectedUnmodifiedStrokeBuffer: IndexedSpriteBuffer2D,
                       pointsUnselectedUnmodifiedFillBuffer: IndexedSpriteBuffer2D,
                       pointsUnselectedModifiedStrokeBuffer: IndexedSpriteBuffer2D,
                       pointsUnselectedModifiedFillBuffer: IndexedSpriteBuffer2D,
                       pointsSelectedBloomBuffer: IndexedSpriteBuffer3D,
                       pointsSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                       pointsSelectedFillBuffer: IndexedSpriteBuffer2DColored,
                       isPrecisePass: Bool,
                       graphicsWidth: Float,
                       graphicsHeight: Float) {
        
        
        guard renderInfo.isShowingJigglePoints else { return }
        
        switch pointsCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && renderInfo.isShowingJigglePointsBloom)
        
        if isBloom {
            pointsUnselectedBloomBuffer.projectionMatrix = orthoMatrix
            pointsUnselectedBloomBuffer.rgba = color_bloom
        }
        
        pointsUnselectedUnmodifiedStrokeBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedUnmodifiedStrokeBuffer.rgba = color_points_unmodified_unselected_stroke
        
        pointsUnselectedUnmodifiedFillBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedUnmodifiedFillBuffer.rgba = color_points_unmodified_unselected_fill
        
        pointsUnselectedModifiedStrokeBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedModifiedStrokeBuffer.rgba = color_points_modified_unselected_stroke
        
        pointsUnselectedModifiedFillBuffer.projectionMatrix = orthoMatrix
        pointsUnselectedModifiedFillBuffer.rgba = color_points_modified_unselected_fill
        
        if isBloom {
            pointsSelectedBloomBuffer.projectionMatrix = orthoMatrix
            pointsSelectedBloomBuffer.rgba = color_bloom
        }
        
        pointsSelectedStrokeBuffer.projectionMatrix = orthoMatrix
        pointsSelectedStrokeBuffer.rgba = color_points_selected_stroke
        
        pointsSelectedFillBuffer.projectionMatrix = orthoMatrix
        //pointsSelectedFillBuffer.rgba = color_points_selected_fill
        
        for jiggleControlPointIndex in 0..<jiggleControlPointCount {
            let jiggleControlPoint = jiggleControlPoints[jiggleControlPointIndex]
            var renderCenterPoint = Math.Point(x: jiggleControlPoint.renderX,
                                               y: jiggleControlPoint.renderY)
            renderCenterPoint = projectionMatrix.process2d(point: renderCenterPoint,
                                                           screenWidth: graphicsWidth,
                                                           screenHeight: graphicsHeight)
            
            switch jiggleControlPoint.renderPointSelected {
                
            case .ignore:
                if isBloom {
                    pointsUnselectedBloomBuffer.add(translation: renderCenterPoint)
                }
                if jiggleControlPoint.isManualTanHandleEnabledIn || jiggleControlPoint.isManualTanHandleEnabledOut {
                    pointsUnselectedModifiedStrokeBuffer.add(translation: renderCenterPoint)
                    pointsUnselectedModifiedFillBuffer.add(translation: renderCenterPoint)
                } else {
                    pointsUnselectedUnmodifiedStrokeBuffer.add(translation: renderCenterPoint)
                    pointsUnselectedUnmodifiedFillBuffer.add(translation: renderCenterPoint)
                }
            case .unselected:
                if isBloom {
                    pointsSelectedBloomBuffer.add(translation: renderCenterPoint)
                }
                pointsSelectedStrokeBuffer.add(translation: renderCenterPoint)
                if jiggleControlPoint.isManualTanHandleEnabledIn || jiggleControlPoint.isManualTanHandleEnabledOut {
                    pointsSelectedFillBuffer.add(translation: renderCenterPoint,
                                                 red: color_points_modified_tanselected_fill.red,
                                                 green: color_points_modified_tanselected_fill.green,
                                                 blue: color_points_modified_tanselected_fill.blue,
                                                 alpha: 1.0)
                } else {
                    pointsSelectedFillBuffer.add(translation: renderCenterPoint,
                                                 red: color_points_unmodified_tanselected_fill.red,
                                                 green: color_points_unmodified_tanselected_fill.green,
                                                 blue: color_points_unmodified_tanselected_fill.blue,
                                                 alpha: 1.0)
                }
            case .selected:
                if isBloom {
                    pointsSelectedBloomBuffer.add(translation: renderCenterPoint)
                }
                pointsSelectedStrokeBuffer.add(translation: renderCenterPoint)
                pointsSelectedFillBuffer.add(translation: renderCenterPoint,
                                             red: color_points_selected_fill.red,
                                             green: color_points_selected_fill.green,
                                             blue: color_points_selected_fill.blue,
                                             alpha: 1.0)
            }
        }
    }
    
    public func renderPointsUnselectedBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                            renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointsBloom {
                pointsUnselectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                          pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderPointsUnselectedUnmodifiedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                       renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsUnselectedUnmodifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsUnselectedUnmodifiedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsUnselectedUnmodifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsUnselectedModifiedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsUnselectedModifiedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsUnselectedModifiedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsUnselectedModifiedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsUnselectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                            renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointsBloom {
                pointsUnselectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                          pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderPointsUnselectedUnmodifiedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                       renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsUnselectedUnmodifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsUnselectedUnmodifiedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsUnselectedUnmodifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsUnselectedModifiedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsUnselectedModifiedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                               pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsUnselectedModifiedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsUnselectedModifiedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                             pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsSelectedBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                          renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointsBloom {
                pointsSelectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                        pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderPointsSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                           renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                     pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                         renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                   pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsSelectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                          renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJigglePointsBloom {
                pointsSelectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                        pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderPointsSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                           renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                     pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderPointsSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                         renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJigglePoints {
            pointsSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                   pipelineState: .spriteNodeColoredWhiteIndexed2DPremultipliedBlending)
        }
    }
}
