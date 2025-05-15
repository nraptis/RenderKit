//
//  JiggleRenderer+JiggleBorderRing.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/24/24.
//

import Foundation
import Metal

extension JiggleRenderer {
    
    public func renderBorderRingBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                      renderInfo: JiggleRenderInfo,
                                      solidLineBufferRegularBloom: SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if isBloomMode {
            if renderInfo.isShowingJiggleBorderRingsBloom {
                solidLineBufferRegularBloom.render(renderEncoder: renderEncoder,
                                                   pipelineState: .shapeNodeIndexed3DNoBlending)
            }
        }
    }
    
    public func renderBorderRingStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                       renderInfo: JiggleRenderInfo,
                                       solidLineBufferRegularStroke: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if renderInfo.isShowingJiggleBorderRings {
            solidLineBufferRegularStroke.render(renderEncoder: renderEncoder,
                                                pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderBorderRingFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                     renderInfo: JiggleRenderInfo,
                                     solidLineBufferRegularFill: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if renderInfo.isShowingJiggleBorderRings {
            solidLineBufferRegularFill.render(renderEncoder: renderEncoder,
                                              pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderBorderRingBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                      renderInfo: JiggleRenderInfo,
                                      solidLineBufferPreciseBloom: SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                                      isJiggleFrozen: Bool) {
        if isBloomMode {
            if renderInfo.isShowingJiggleBorderRingsBloom {
                if !isJiggleFrozen {
                    solidLineBufferPreciseBloom.render(renderEncoder: renderEncoder,
                                                       pipelineState: .shapeNodeIndexed3DNoBlending)
                }
            }
        }
    }
    
    public func renderBorderRingStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                       renderInfo: JiggleRenderInfo,
                                       solidLineBufferPreciseStroke: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if renderInfo.isShowingJiggleBorderRings {
            solidLineBufferPreciseStroke.render(renderEncoder: renderEncoder,
                                                pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderBorderRingFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                     renderInfo: JiggleRenderInfo,
                                     solidLineBufferPreciseFill:SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if renderInfo.isShowingJiggleBorderRings {
            solidLineBufferPreciseFill.render(renderEncoder: renderEncoder,
                                              pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
}
