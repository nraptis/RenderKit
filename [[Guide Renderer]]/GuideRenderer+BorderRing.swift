//
//  GuideRenderer+JiggleBorderRing.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/29/24.
//

import Foundation
import Metal

extension GuideRenderer {
    
    public func renderBorderRingBloomRegular(renderEncoder: MTLRenderCommandEncoder,
                                             renderInfo: JiggleRenderInfo,
                                             solidLineBufferRegularBloom: SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuideBorderRingsBloom {
                    solidLineBufferRegularBloom.render(renderEncoder: renderEncoder,
                                                       pipelineState: .shapeNodeIndexed3DNoBlending)
                }
            }
        }
    }
    
    public func renderBorderRingBloomPrecise(renderEncoder: MTLRenderCommandEncoder,
                                             renderInfo: JiggleRenderInfo,
                                             solidLineBufferPreciseBloom: SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if isBloomMode {
            if !isFrozen && isSelected {
                if renderInfo.isShowingGuideBorderRingsBloom {
                    solidLineBufferPreciseBloom.render(renderEncoder: renderEncoder,
                                                       pipelineState: .shapeNodeIndexed3DNoBlending)
                }
            }
        }
    }
    
    public func renderBorderRingStrokeRegular(renderEncoder: MTLRenderCommandEncoder,
                                              renderInfo: JiggleRenderInfo,
                                              solidLineBufferRegularStroke: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if renderInfo.isShowingGuideBorderRings {
            solidLineBufferRegularStroke.render(renderEncoder: renderEncoder,
                                                pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderBorderRingStrokePrecise(renderEncoder: MTLRenderCommandEncoder,
                                              renderInfo: JiggleRenderInfo,
                                              solidLineBufferPreciseStroke: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if renderInfo.isShowingGuideBorderRings {
            solidLineBufferPreciseStroke.render(renderEncoder: renderEncoder,
                                                pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderBorderRingFillRegular(renderEncoder: MTLRenderCommandEncoder,
                                            renderInfo: JiggleRenderInfo,
                                            solidLineBufferRegularFill: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if renderInfo.isShowingGuideBorderRings {
            solidLineBufferRegularFill.render(renderEncoder: renderEncoder,
                                              pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
    public func renderBorderRingFillPrecise(renderEncoder: MTLRenderCommandEncoder,
                                            renderInfo: JiggleRenderInfo,
                                            solidLineBufferPreciseFill: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>) {
        if renderInfo.isShowingGuideBorderRings {
            solidLineBufferPreciseFill.render(renderEncoder: renderEncoder,
                                              pipelineState: .shapeNodeIndexed2DNoBlending)
        }
    }
    
}
