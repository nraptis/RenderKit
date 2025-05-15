//
//  JiggleRenderer+JigglePointTanPoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/25/24.
//

import Foundation
import Metal
import simd
import MathKit

extension JiggleRenderer {
    
    public func pre_prepareTanPoints(renderInfo: JiggleRenderInfo) {
        
        guard renderInfo.isShowingJiggleControlPointTanHandles else { return }
        
        if isJiggleFrozen {
            color_tan_points_unselected_stroke = RTJ.strokeDis(isDarkMode: isDarkMode)
            color_tan_points_unselected_fill = RTJ.fillDis(isDarkMode: isDarkMode)
            return
        }
        
        switch tansCreatorModeFormat {
        case .regular, .invalid:
            if isJiggleSelected {
                color_tan_points_unselected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTJ.tanPointFillSel(isDarkMode: isDarkMode)
                color_tan_points_selected_stroke = RTJ.strokeRegSel(isDarkMode: isDarkMode)
                color_tan_points_selected_fill = RTJ.fillGrb(isDarkMode: isDarkMode)
            } else {
                color_tan_points_unselected_stroke = RTJ.strokeRegUns(isDarkMode: isDarkMode)
                color_tan_points_unselected_fill = RTJ.tanPointFillUns(isDarkMode: isDarkMode)
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
                          jiggleControlPoints: [some RenderControlPoint],
                          jiggleControlPointCount: Int,
                          tanHandlePointsUnselectedBloomBuffer: IndexedSpriteBuffer3D,
                          tanHandlePointsUnselectedStrokeBuffer: IndexedSpriteBuffer2D,
                          tanHandlePointsUnselectedFillBuffer: IndexedSpriteBuffer2D,
                          tanHandlePointsSelectedBloomBuffer: IndexedSpriteBuffer3D,
                          tanHandlePointsSelectedStrokeBuffer: IndexedSpriteBuffer2D,
                          tanHandlePointsSelectedFillBuffer: IndexedSpriteBuffer2D,
                          isPrecisePass: Bool,
                          graphicsWidth: Float,
                          graphicsHeight: Float) {
        
        guard renderInfo.isShowingJiggleControlPointTanHandles else { return }
        
        switch tansCreatorModeFormat {
        case .invalid:
            return
        default:
            break
        }
        
        let isBloom = (isBloomMode && renderInfo.isShowingJiggleControlPointTanHandlesBloom)
        
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
        
        for jiggleControlPointIndex in 0..<jiggleControlPointCount {
            let jiggleControlPoint = jiggleControlPoints[jiggleControlPointIndex]
            var renderCenterPointIn = Math.Point(x: jiggleControlPoint.renderTanInX,
                                                 y: jiggleControlPoint.renderTanInY)
            renderCenterPointIn = projectionMatrix.process2d(point: renderCenterPointIn,
                                                             screenWidth: graphicsWidth,
                                                             screenHeight: graphicsHeight)
            
            var renderCenterPointOut = Math.Point(x: jiggleControlPoint.renderTanOutX,
                                                  y: jiggleControlPoint.renderTanOutY)
            renderCenterPointOut = projectionMatrix.process2d(point: renderCenterPointOut,
                                                              screenWidth: graphicsWidth,
                                                              screenHeight: graphicsHeight)
            
            if jiggleControlPoint.renderTanInSelected {
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
            
            if jiggleControlPoint.renderTanOutSelected {
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
            if renderInfo.isShowingJiggleControlPointTanHandlesBloom {
                tanHandlePointsUnselectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderTanHandlePointsUnselectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                      renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJiggleControlPointTanHandles {
            tanHandlePointsUnselectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsUnselectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                    renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJiggleControlPointTanHandles {
            tanHandlePointsUnselectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsUnselectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                     renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJiggleControlPointTanHandlesBloom {
                tanHandlePointsUnselectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                   pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderTanHandlePointsUnselectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                      renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJiggleControlPointTanHandles {
            tanHandlePointsUnselectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                                pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsUnselectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                    renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJiggleControlPointTanHandles {
            tanHandlePointsUnselectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJiggleControlPointTanHandlesBloom {
                tanHandlePointsSelectedRegularBloomBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderTanHandlePointsSelectedStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                                    renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJiggleControlPointTanHandles {
            tanHandlePointsSelectedRegularStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                                  renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJiggleControlPointTanHandles {
            tanHandlePointsSelectedRegularFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                   renderInfo: JiggleRenderInfo) {
        if isBloomMode {
            if renderInfo.isShowingJiggleControlPointTanHandlesBloom {
                tanHandlePointsSelectedPreciseBloomBuffer.render(renderEncoder: renderEncoder,
                                                                 pipelineState: .spriteNodeIndexed3DAlphaBlending)
            }
        }
    }
    
    public func renderTanHandlePointsSelectedStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                                    renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJiggleControlPointTanHandles {
            tanHandlePointsSelectedPreciseStrokeBuffer.render(renderEncoder: renderEncoder,
                                                              pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
    
    public func renderTanHandlePointsSelectedFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                                  renderInfo: JiggleRenderInfo) {
        if renderInfo.isShowingJiggleControlPointTanHandles {
            tanHandlePointsSelectedPreciseFillBuffer.render(renderEncoder: renderEncoder,
                                                            pipelineState: .spriteNodeWhiteIndexed2DPremultipliedBlending)
        }
    }
}
