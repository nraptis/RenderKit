//
//  GuideRenderer+JigglePointTanPoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/29/24.
//

import Foundation
import Metal
import simd
import MathKit

extension GuideRenderer {
    
    public func pre_prepareTanPoints(renderInfo: JiggleRenderInfo) {
        
        guard renderInfo.isShowingGuideControlPointTanHandles else { return }
        
        if isFrozen {
            color_tan_points_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_tan_points_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            return
        }
        
        switch tansCreatorModeFormat {
        case .regular, .invalid:
            if isJiggleSelected {
                color_tan_points_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTG.tanPointFillSel(index: weightDepthIndex,
                                                                       isDarkMode: isDarkMode)
                color_tan_points_selected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_tan_points_selected_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
            } else {
                color_tan_points_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTG.tanPointFillUns(index: weightDepthIndex,
                                                                       isDarkMode: isDarkMode)
            }
        case .alternative:
            if isJiggleSelected {
                color_tan_points_unselected_stroke = RTJ.strokeAltSel(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTJ.fillAltSelUnm(isDarkMode: isDarkMode)
            } else {
                color_tan_points_unselected_stroke = RTJ.strokeAltUns(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTJ.fillAltUnsUnm(isDarkMode: isDarkMode)
            }
        }
    }
    
    // @Precondition: pre_prepareTanPoints()
    // @Precondition: pre_prepareTanLines
    public func prepareTanPoints(renderInfo: JiggleRenderInfo,
                                 guideControlPoints: [some RenderControlPoint],
                                 guideControlPointCount: Int,
                                 tanHandlePointsUnselectedBloomBuffer: IndexedSpriteBuffer3D,
                                 tanHandlePointsUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                                 tanHandlePointsUnselectedFillBuffer: IndexedSpriteBuffer2D,
                                 tanHandlePointsSelectedBloomBuffer: IndexedSpriteBuffer3D,
                                 tanHandlePointsSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                                 tanHandlePointsSelectedFillBuffer: IndexedSpriteBuffer2D,
                                 isPrecisePass: Bool,
                                 graphicsWidth: Float,
                                 graphicsHeight: Float) {
        
        guard renderInfo.isShowingGuideControlPointTanHandles else { return }
        
        switch tansCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && renderInfo.isShowingGuideControlPointTanHandlesBloom)
        
        if isBloom {
            tanHandlePointsUnselectedBloomBuffer.projectionMatrix = orthoMatrix
            tanHandlePointsUnselectedBloomBuffer.rgba = color_bloom
        }
        
        tanHandlePointsUnselectedStrokeBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsUnselectedStrokeBuffer.rgba = color_tan_points_unselected_stroke
        
        tanHandlePointsUnselectedFillBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsUnselectedFillBuffer.rgba = color_tan_points_unselected_fill
        
        if isBloom {
            tanHandlePointsSelectedBloomBuffer.projectionMatrix = orthoMatrix
            tanHandlePointsSelectedBloomBuffer.rgba = color_bloom
        }
        
        tanHandlePointsSelectedStrokeBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsSelectedStrokeBuffer.rgba = color_tan_points_selected_stroke
        
        tanHandlePointsSelectedFillBuffer.projectionMatrix = orthoMatrix
        tanHandlePointsSelectedFillBuffer.rgba = color_tan_points_selected_fill
        
        for guideControlPointIndex in 0..<guideControlPointCount {
            let guideControlPoint = guideControlPoints[guideControlPointIndex]
            
            var renderCenterPointIn = Math.Point(x: guideControlPoint.renderTanInX,
                                                 y: guideControlPoint.renderTanInY)
            renderCenterPointIn = projectionMatrix.process2d(point: renderCenterPointIn,
                                                             screenWidth: graphicsWidth,
                                                             screenHeight: graphicsHeight)
            
            var renderCenterPointOut = Math.Point(x: guideControlPoint.renderTanOutX,
                                                  y: guideControlPoint.renderTanOutY)
            renderCenterPointOut = projectionMatrix.process2d(point: renderCenterPointOut,
                                                              screenWidth: graphicsWidth,
                                                              screenHeight: graphicsHeight)
            
            if guideControlPoint.renderTanInSelected {
                if isBloom {
                    tanHandlePointsSelectedBloomBuffer.add(translation: renderCenterPointIn)
                }
                tanHandlePointsSelectedStrokeBuffer.add(translation: renderCenterPointIn)
                tanHandlePointsSelectedFillBuffer.add(translation: renderCenterPointIn)
            } else {
                if isBloom {
                    tanHandlePointsUnselectedBloomBuffer.add(translation: renderCenterPointIn)
                }
                tanHandlePointsUnselectedStrokeBuffer.add(translation: renderCenterPointIn)
                tanHandlePointsUnselectedFillBuffer.add(translation: renderCenterPointIn)
            }
            
            if guideControlPoint.renderTanOutSelected {
                if isBloom {
                    tanHandlePointsSelectedBloomBuffer.add(translation: renderCenterPointOut)
                }
                tanHandlePointsSelectedStrokeBuffer.add(translation: renderCenterPointOut)
                tanHandlePointsSelectedFillBuffer.add(translation: renderCenterPointOut)
                
            } else {
                if isBloom {
                    tanHandlePointsUnselectedBloomBuffer.add(translation: renderCenterPointOut)
                }
                tanHandlePointsUnselectedStrokeBuffer.add(translation: renderCenterPointOut)
                tanHandlePointsUnselectedFillBuffer.add(translation: renderCenterPointOut)
            }
        }
    }
    
    public func renderTanHandlePointsUnselectedBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                                            renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuideControlPointTanHandlesBloom {
                    tanHandlePointsUnselectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                       pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    public func renderTanHandlePointsUnselectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                             renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuideControlPointTanHandles {
            tanHandlePointsUnselectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsUnselectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                           renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuideControlPointTanHandles {
            tanHandlePointsUnselectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsUnselectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                            renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuideControlPointTanHandlesBloom {
                    tanHandlePointsUnselectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                       pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    public func renderTanHandlePointsUnselectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                             renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuideControlPointTanHandles {
            tanHandlePointsUnselectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsUnselectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                           renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuideControlPointTanHandles {
            tanHandlePointsUnselectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                                          renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuideControlPointTanHandlesBloom {
                    tanHandlePointsSelectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                     pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    public func renderTanHandlePointsSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                           renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuideControlPointTanHandles {
            tanHandlePointsSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                         renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuideControlPointTanHandles {
            tanHandlePointsSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                          renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuideControlPointTanHandlesBloom {
                    tanHandlePointsSelectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                     pipelineState: .spriteNodeIndexed3DAlphaBlending)
                }
            }
        }
    }
    
    public func renderTanHandlePointsSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                           renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuideControlPointTanHandles {
            tanHandlePointsSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                         renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingGuideControlPointTanHandles {
            tanHandlePointsSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
}
