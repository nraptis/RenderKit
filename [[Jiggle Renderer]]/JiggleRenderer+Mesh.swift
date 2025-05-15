//
//  JiggleRenderer+Mesh.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/28/24.
//

import Foundation
import Metal
import simd

extension JiggleRenderer {
    
    public func renderMesh2DRegular(renderEncoder: MTLRenderCommandEncoder,
                                    renderInfo: JiggleRenderInfo,
                                    editBufferStandardRegular: IndexedShapeBuffer2DColored,
                                    editBufferWeightsRegular: IndexedShapeBuffer2DColored) {
        
        
        if renderInfo.isShowingMeshEditStandard {
            editBufferStandardRegular.render(renderEncoder: renderEncoder,
                                             pipelineState: Graphics.PipelineState.shapeNodeColoredIndexed2DAlphaBlending)
            
        } else if renderInfo.isShowingMeshEditWeights {
            editBufferWeightsRegular.render(renderEncoder: renderEncoder,
                                            pipelineState: Graphics.PipelineState.shapeNodeColoredIndexed2DAlphaBlending)
        }
    }
    
    public func renderMesh2DPrecise(renderEncoder: MTLRenderCommandEncoder,
                                    renderInfo: JiggleRenderInfo,
                                    editBufferStandardPrecise: IndexedShapeBuffer2DColored,
                                    editBufferWeightsPrecise: IndexedShapeBuffer2DColored) {
        
        if renderInfo.isShowingMeshEditStandard {
            editBufferStandardPrecise.render(renderEncoder: renderEncoder,
                                             pipelineState: Graphics.PipelineState.shapeNodeColoredIndexed2DAlphaBlending)
        } else if renderInfo.isShowingMeshEditWeights {
            editBufferWeightsPrecise.render(renderEncoder: renderEncoder,
                                            pipelineState: Graphics.PipelineState.shapeNodeColoredIndexed2DAlphaBlending)
        }
    }
    
    public func renderMesh3D(renderEncoder: MTLRenderCommandEncoder,
                             renderInfo: JiggleRenderInfo,
                             viewBuffer: IndexedSpriteBuffer3D) {
        if renderInfo.isShowingMeshViewStandard {
            viewBuffer.render(renderEncoder: renderEncoder,
                              pipelineState: Graphics.PipelineState.spriteNodeIndexed3DNoBlending)
        }
    }
    
    public func renderMesh3DStereoscopicBlue(renderEncoder: MTLRenderCommandEncoder,
                                             renderInfo: JiggleRenderInfo,
                                             viewBufferStereoscopic: IndexedSpriteBuffer3DStereoscopic) {
        if renderInfo.isShowingMeshViewStereoscopic {
            viewBufferStereoscopic.render(renderEncoder: renderEncoder,
                                          pipelineState: Graphics.PipelineState.spriteNodeStereoscopicBlueIndexed3DNoBlending)
        }
    }
    
    public func renderMesh3DStereoscopicRed(renderEncoder: MTLRenderCommandEncoder,
                                            renderInfo: JiggleRenderInfo,
                                            viewBufferStereoscopic: IndexedSpriteBuffer3DStereoscopic) {
        if renderInfo.isShowingMeshViewStereoscopic {
            viewBufferStereoscopic.render(renderEncoder: renderEncoder,
                                          pipelineState: Graphics.PipelineState.spriteNodeStereoscopicRedIndexed3DNoBlending)
        }
    }
    
}
