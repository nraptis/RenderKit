//
//  GuideRenderer.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/29/24.
//

import Foundation
import Metal
import simd
import MathKit
import TypeKit

public class GuideRenderer {
    
    var weightDepthIndex = -1
    
    var color_bloom = RGBA()
    
    var color_points_unmodified_unselected_stroke = RGBA()
    var color_points_unmodified_unselected_fill = RGBA()
    var color_points_modified_unselected_stroke = RGBA()
    var color_points_modified_unselected_fill = RGBA()
    var color_points_selected_stroke = RGBA()
    var color_points_selected_fill = RGBA()
    var color_points_unmodified_tanselected_fill = RGBA()
    var color_points_modified_tanselected_fill = RGBA()
    
    var color_tan_lines_unselected_stroke = RGBA()
    var color_tan_lines_unselected_fill = RGBA()
    var color_tan_lines_selected_stroke = RGBA()
    var color_tan_lines_selected_fill = RGBA()
    
    var color_tan_points_unselected_stroke = RGBA()
    var color_tan_points_unselected_fill = RGBA()
    var color_tan_points_selected_stroke = RGBA()
    var color_tan_points_selected_fill = RGBA()
    
    var pointsCreatorModeFormat = PointsCreatorModeFormat.invalid
    var tansCreatorModeFormat = TansCreatorModeFormat.invalid
    
    var isJiggleSelected = false
    var isJiggleFrozen = false
    var isSelected = false
    
    var isGuideSelected = false
    var isGuideFrozen = false
    public var isFrozen = false
    
    var isDarkMode = false
    var isStereoscopicMode = false
    var isBloomMode = false
    
    var isRenderingPrecise = false
    
    var orthoMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
    
    var worldScale = Float(1.0)
    
    var inverseRotation = Float(1.0)
    
    var weightMode = WeightMode.guides
    var creatorMode = CreatorMode.none
    
    var selectedTanType = TanTypeOrNone.none
    var pointSelectionMode = PointSelectionModality.points
    
    var lineWidthFillBase = Float(8.0)
    var lineWidthStrokeBase = Float(12.0)
    
    // Points Unselected:
    let pointsUnselectedRegularBloomBuffer = IndexedSpriteBuffer3D()
    let pointsUnselectedUnmodifiedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedUnmodifiedRegularFillBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedModifiedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedModifiedRegularFillBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedPreciseBloomBuffer = IndexedSpriteBuffer3D()
    let pointsUnselectedUnmodifiedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedUnmodifiedPreciseFillBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedModifiedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsUnselectedModifiedPreciseFillBuffer = IndexedSpriteBuffer2D()
    
    // Points Selected:
    let pointsSelectedRegularBloomBuffer = IndexedSpriteBuffer3D()
    let pointsSelectedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsSelectedRegularFillBuffer = IndexedSpriteBuffer2DColored()
    let pointsSelectedPreciseBloomBuffer = IndexedSpriteBuffer3D()
    let pointsSelectedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let pointsSelectedPreciseFillBuffer = IndexedSpriteBuffer2DColored()
    
    // Tan Lines Unselected:
    let tanHandleLinesRegularBloomBuffer = IndexedShapeBuffer3D()
    let tanHandleLinesUnselectedRegularStrokeBuffer = IndexedShapeBuffer2D()
    let tanHandleLinesUnselectedRegularFillBuffer = IndexedShapeBuffer2D()
    
    let tanHandleLinesPreciseBloomBuffer = IndexedShapeBuffer3D()
    let tanHandleLinesUnselectedPreciseStrokeBuffer = IndexedShapeBuffer2D()
    let tanHandleLinesUnselectedPreciseFillBuffer = IndexedShapeBuffer2D()
    
    // Tan Lines Selected:
    let tanHandleLinesSelectedRegularStrokeBuffer = IndexedShapeBuffer2D()
    let tanHandleLinesSelectedRegularFillBuffer = IndexedShapeBuffer2D()
    
    let tanHandleLinesSelectedPreciseStrokeBuffer = IndexedShapeBuffer2D()
    let tanHandleLinesSelectedPreciseFillBuffer = IndexedShapeBuffer2D()
    
    // Tan Points Unselected:
    let tanHandlePointsUnselectedRegularBloomBuffer = IndexedSpriteBuffer3D()
    let tanHandlePointsUnselectedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let tanHandlePointsUnselectedRegularFillBuffer = IndexedSpriteBuffer2D()
    
    let tanHandlePointsUnselectedPreciseBloomBuffer = IndexedSpriteBuffer3D()
    let tanHandlePointsUnselectedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let tanHandlePointsUnselectedPreciseFillBuffer = IndexedSpriteBuffer2D()
    
    // Tan Points Selected:
    let tanHandlePointsSelectedRegularBloomBuffer = IndexedSpriteBuffer3D()
    let tanHandlePointsSelectedRegularStrokeBuffer = IndexedSpriteBuffer2D()
    let tanHandlePointsSelectedRegularFillBuffer = IndexedSpriteBuffer2D()
    
    let tanHandlePointsSelectedPreciseBloomBuffer = IndexedSpriteBuffer3D()
    let tanHandlePointsSelectedPreciseStrokeBuffer = IndexedSpriteBuffer2D()
    let tanHandlePointsSelectedPreciseFillBuffer = IndexedSpriteBuffer2D()
    
    var isLoaded = false
    
    public init() {
        
    }
    
    public func reset() {
        
        // Points Unselected:
        pointsUnselectedRegularBloomBuffer.reset()
        pointsUnselectedUnmodifiedRegularStrokeBuffer.reset()
        pointsUnselectedUnmodifiedRegularFillBuffer.reset()
        pointsUnselectedModifiedRegularStrokeBuffer.reset()
        pointsUnselectedModifiedRegularFillBuffer.reset()
        
        pointsUnselectedPreciseBloomBuffer.reset()
        pointsUnselectedUnmodifiedPreciseStrokeBuffer.reset()
        pointsUnselectedUnmodifiedPreciseFillBuffer.reset()
        pointsUnselectedModifiedPreciseStrokeBuffer.reset()
        pointsUnselectedModifiedPreciseFillBuffer.reset()
        
        // Points Selected:
        pointsSelectedRegularBloomBuffer.reset()
        pointsSelectedRegularStrokeBuffer.reset()
        pointsSelectedRegularFillBuffer.reset()
        pointsSelectedPreciseBloomBuffer.reset()
        pointsSelectedPreciseStrokeBuffer.reset()
        pointsSelectedPreciseFillBuffer.reset()
        
        // Tan Lines Unselected:
        tanHandleLinesRegularBloomBuffer.reset()
        tanHandleLinesUnselectedRegularStrokeBuffer.reset()
        tanHandleLinesUnselectedRegularFillBuffer.reset()
        
        tanHandleLinesPreciseBloomBuffer.reset()
        tanHandleLinesUnselectedPreciseStrokeBuffer.reset()
        tanHandleLinesUnselectedPreciseFillBuffer.reset()
        
        // Tan Lines Selected:
        tanHandleLinesSelectedRegularStrokeBuffer.reset()
        tanHandleLinesSelectedRegularFillBuffer.reset()
        
        tanHandleLinesSelectedPreciseStrokeBuffer.reset()
        tanHandleLinesSelectedPreciseFillBuffer.reset()
        
        // Tan Points Unselected:
        tanHandlePointsUnselectedRegularBloomBuffer.reset()
        tanHandlePointsUnselectedRegularStrokeBuffer.reset()
        tanHandlePointsUnselectedRegularFillBuffer.reset()
        
        tanHandlePointsUnselectedPreciseBloomBuffer.reset()
        tanHandlePointsUnselectedPreciseStrokeBuffer.reset()
        tanHandlePointsUnselectedPreciseFillBuffer.reset()
        
        // Tan Points Selected:
        tanHandlePointsSelectedRegularBloomBuffer.reset()
        tanHandlePointsSelectedRegularStrokeBuffer.reset()
        tanHandlePointsSelectedRegularFillBuffer.reset()
        
        tanHandlePointsSelectedPreciseBloomBuffer.reset()
        tanHandlePointsSelectedPreciseStrokeBuffer.reset()
        tanHandlePointsSelectedPreciseFillBuffer.reset()
    }
    
    public func pre_prepare(renderInfo: JiggleRenderInfo,
                            guideControlPoints: [some RenderControlPoint],
                            guideControlPointCount: Int,
                            isJiggleSelected: Bool,
                            isJiggleFrozen: Bool,
                            isGuideFrozen: Bool,
                            weightDepthIndex: Int,
                            isGuideSelected: Bool,
                            selectedGuideControlPointIndex: Int,
                            creatorMode: CreatorMode,
                            weightMode: WeightMode,
                            selectedTanType: TanTypeOrNone,
                            pointSelectionMode: PointSelectionModality,
                            isBloomMode: Bool,
                            jiggleCenter: Math.Point,
                            jiggleScale: Float,
                            jiggleRotation: Float,
                            guideCenter: Math.Point,
                            guideScale: Float,
                            guideRotation: Float,
                            graphicsWidth: Float,
                            graphicsHeight: Float) {
        
        orthoMatrix.ortho(width: graphicsWidth,
                          height: graphicsHeight)
        
        self.isJiggleSelected = isJiggleSelected
        self.weightDepthIndex = weightDepthIndex
        self.isGuideSelected = isGuideSelected
        self.isJiggleFrozen = isJiggleFrozen
        self.isGuideFrozen = isGuideFrozen
        self.isDarkMode = renderInfo.isShowingDarkMode
        self.isStereoscopicMode = renderInfo.isShowingMeshViewStereoscopic
        self.weightMode = weightMode
        self.creatorMode = creatorMode
        self.selectedTanType = selectedTanType
        self.pointSelectionMode = pointSelectionMode
        self.isBloomMode = isBloomMode
        isSelected = (isJiggleSelected && isGuideSelected)
        isFrozen = (isJiggleFrozen || isGuideFrozen)
        
        pointsCreatorModeFormat = getPointsCreatorModeFormat(creatorMode: creatorMode)
        tansCreatorModeFormat = getTansCreatorModeFormat(creatorMode: creatorMode)
        
        pre_preparePoints(renderInfo: renderInfo)
        pre_prepareTanLines(renderInfo: renderInfo)
        pre_prepareTanPoints(renderInfo: renderInfo)
        
        color_bloom = RTJ.bloom(isDarkMode: isDarkMode)
        
        // Anything we can compute once, we will do outside of the 2 renderings...
        if renderInfo.isShowingGuidePoints {
            let isAbleToShowSelectedPoint: RenderPointSelectedStrategy
            let isAbleToShowSelectedTan: Bool
            
            if isFrozen {
                isAbleToShowSelectedPoint = RenderPointSelectedStrategy.ignore
                isAbleToShowSelectedTan = false
            } else {
                switch selectedTanType {
                case .none:
                    switch pointsCreatorModeFormat {
                    case .invalid:
                        isAbleToShowSelectedPoint = RenderPointSelectedStrategy.ignore
                    case .regular:
                        isAbleToShowSelectedPoint = RenderPointSelectedStrategy.selected
                    case .alternative:
                        isAbleToShowSelectedPoint = RenderPointSelectedStrategy.ignore
                    }
                    isAbleToShowSelectedTan = false
                case .in:
                    isAbleToShowSelectedPoint = RenderPointSelectedStrategy.unselected
                    switch tansCreatorModeFormat {
                    case .invalid:
                        isAbleToShowSelectedTan = false
                    case .regular:
                        isAbleToShowSelectedTan = true
                    case .alternative:
                        isAbleToShowSelectedTan = false
                    }
                case .out:
                    isAbleToShowSelectedPoint = RenderPointSelectedStrategy.unselected
                    switch tansCreatorModeFormat {
                    case .invalid:
                        isAbleToShowSelectedTan = false
                    case .regular:
                        isAbleToShowSelectedTan = true
                    case .alternative:
                        isAbleToShowSelectedTan = false
                    }
                }
            }
            
            for guideControlPointIndex in 0..<guideControlPointCount {
                let guideControlPoint = guideControlPoints[guideControlPointIndex]
                
                var renderPoint = guideControlPoint.point
                
                renderPoint = Math.transformPoint(point: renderPoint,
                                                  translation: guideCenter,
                                                  scale: guideScale,
                                                  rotation: guideRotation)
                
                renderPoint = Math.transformPoint(point: renderPoint,
                                                  translation: jiggleCenter,
                                                  scale: jiggleScale,
                                                  rotation: jiggleRotation)
                
                let isPointSelected: RenderPointSelectedStrategy
                
                switch isAbleToShowSelectedPoint {
                case .ignore:
                    isPointSelected = RenderPointSelectedStrategy.ignore
                case .unselected:
                    if isSelected == true {
                        if selectedGuideControlPointIndex == guideControlPointIndex {
                            isPointSelected = RenderPointSelectedStrategy.unselected
                        } else {
                            isPointSelected = RenderPointSelectedStrategy.ignore
                        }
                    } else {
                        isPointSelected = RenderPointSelectedStrategy.ignore
                    }
                case .selected:
                    if isSelected == true {
                        if selectedGuideControlPointIndex == guideControlPointIndex {
                            isPointSelected = RenderPointSelectedStrategy.selected
                        } else {
                            isPointSelected = RenderPointSelectedStrategy.ignore
                        }
                    } else {
                        isPointSelected = RenderPointSelectedStrategy.ignore
                    }
                }
                
                guideControlPoint.renderX = renderPoint.x
                guideControlPoint.renderY = renderPoint.y
                guideControlPoint.renderPointSelected = isPointSelected
                
                var isTanInSelected = false
                var isTanOutSelected = false
                if isAbleToShowSelectedTan {
                    if isSelected {
                        if selectedGuideControlPointIndex == guideControlPointIndex {
                            switch selectedTanType {
                            case .none:
                                break
                            case .in:
                                isTanInSelected = true
                            case .out:
                                isTanOutSelected = true
                            }
                        }
                    }
                }
                
                guideControlPoint.renderTanInSelected = isTanInSelected
                guideControlPoint.renderTanOutSelected = isTanOutSelected
                
            }
        }
        
        // Anything we can compute once, we will do outside of the 2 renderings...
        if renderInfo.isShowingGuideControlPointTanHandles {
            for guideControlPointIndex in 0..<guideControlPointCount {
                let guideControlPoint = guideControlPoints[guideControlPointIndex]
                
                var tanHandleIn = guideControlPoint.getTanHandleIn()
                tanHandleIn = Math.transformPoint(point: tanHandleIn,
                                                  translation: guideCenter,
                                                  scale: guideScale,
                                                  rotation: guideRotation)
                tanHandleIn = Math.transformPoint(point: tanHandleIn,
                                                  translation: jiggleCenter,
                                                  scale: jiggleScale,
                                                  rotation: jiggleRotation)
                
                var tanHandleOut = guideControlPoint.getTanHandleOut()
                tanHandleOut = Math.transformPoint(point: tanHandleOut,
                                                   translation: guideCenter,
                                                   scale: guideScale,
                                                   rotation: guideRotation)
                tanHandleOut = Math.transformPoint(point: tanHandleOut,
                                                   translation: jiggleCenter,
                                                   scale: jiggleScale,
                                                   rotation: jiggleRotation)
                
                guideControlPoint.renderTanInX = tanHandleIn.x
                guideControlPoint.renderTanInY = tanHandleIn.y
                
                guideControlPoint.renderTanOutX = tanHandleOut.x
                guideControlPoint.renderTanOutY = tanHandleOut.y
                
                var tanNormalsIn = guideControlPoint.getTanHandleNormalsIn()
                tanNormalsIn = Math.transformVector(vector: tanNormalsIn,
                                                    scale: 1.0,
                                                    rotation: guideRotation)
                tanNormalsIn = Math.transformVector(vector: tanNormalsIn,
                                                    scale: 1.0,
                                                    rotation: jiggleRotation)
                
                guideControlPoint.renderTanNormalInX = tanNormalsIn.x
                guideControlPoint.renderTanNormalInY = tanNormalsIn.y
                
                var tanNormalsOut = guideControlPoint.getTanHandleNormalsOut()
                tanNormalsOut = Math.transformVector(vector: tanNormalsOut,
                                                     scale: 1.0,
                                                     rotation: guideRotation)
                tanNormalsOut = Math.transformVector(vector: tanNormalsOut,
                                                     scale: 1.0,
                                                     rotation: jiggleRotation)
                guideControlPoint.renderTanNormalOutX = tanNormalsOut.x
                guideControlPoint.renderTanNormalOutY = tanNormalsOut.y
            }
        }
    }
    
    // We load up all the buffers for the render, this does not render anything...
    public func prepare(renderInfo: JiggleRenderInfo,
                        guideControlPoints: [some RenderControlPoint],
                        guideControlPointCount: Int,
                        solidLineBufferRegularBloom: SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferRegularStroke: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferRegularFill: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferPreciseBloom: SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferPreciseStroke: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferPreciseFill: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        projectionMatrix: matrix_float4x4,
                        isPrecisePass: Bool,
                        isRenderingPrecise: Bool,
                        worldScale_Precise: Float,
                        inverseRotation_Precise: Float,
                        worldScale_Normal: Float,
                        inverseRotation_Normal: Float,
                        graphicsWidth: Float,
                        graphicsHeight: Float) {
        
        self.projectionMatrix = projectionMatrix
        self.isRenderingPrecise = isRenderingPrecise
        
        if isPrecisePass {
            worldScale = worldScale_Precise
            inverseRotation = inverseRotation_Precise
        } else {
            worldScale = worldScale_Normal
            inverseRotation = inverseRotation_Normal
        }
        
        let pointsUnselectedBloomBuffer: IndexedSpriteBuffer3D
        let pointsUnselectedUnmodifiedStrokeBuffer: IndexedSpriteBuffer2D
        let pointsUnselectedUnmodifiedFillBuffer: IndexedSpriteBuffer2D
        let pointsUnselectedModifiedStrokeBuffer: IndexedSpriteBuffer2D
        let pointsUnselectedModifiedFillBuffer: IndexedSpriteBuffer2D
        
        let pointsSelectedBloomBuffer: IndexedSpriteBuffer3D
        let pointsSelectedStrokeBuffer: IndexedSpriteBuffer2D
        let pointsSelectedFillBuffer: IndexedSpriteBuffer2DColored
        
        let tanHandleLinesBloomBuffer: IndexedShapeBuffer3D
        let tanHandleLinesUnselectedStrokeBuffer: IndexedShapeBuffer2D
        let tanHandleLinesUnselectedFillBuffer: IndexedShapeBuffer2D
        let tanHandleLinesSelectedStrokeBuffer: IndexedShapeBuffer2D
        let tanHandleLinesSelectedFillBuffer: IndexedShapeBuffer2D
        
        let tanHandlePointsUnselectedBloomBuffer: IndexedSpriteBuffer3D
        let tanHandlePointsUnselectedStrokeBuffer: IndexedSpriteBuffer2D
        let tanHandlePointsUnselectedFillBuffer: IndexedSpriteBuffer2D
        let tanHandlePointsSelectedBloomBuffer: IndexedSpriteBuffer3D
        let tanHandlePointsSelectedStrokeBuffer: IndexedSpriteBuffer2D
        let tanHandlePointsSelectedFillBuffer: IndexedSpriteBuffer2D
        
        if isPrecisePass {
            
            pointsUnselectedBloomBuffer = pointsUnselectedPreciseBloomBuffer
            pointsUnselectedUnmodifiedStrokeBuffer = pointsUnselectedUnmodifiedPreciseStrokeBuffer
            pointsUnselectedUnmodifiedFillBuffer = pointsUnselectedUnmodifiedPreciseFillBuffer
            pointsUnselectedModifiedStrokeBuffer = pointsUnselectedModifiedPreciseStrokeBuffer
            pointsUnselectedModifiedFillBuffer = pointsUnselectedModifiedPreciseFillBuffer
            
            pointsSelectedBloomBuffer = pointsSelectedPreciseBloomBuffer
            pointsSelectedStrokeBuffer = pointsSelectedPreciseStrokeBuffer
            pointsSelectedFillBuffer = pointsSelectedPreciseFillBuffer
            
            tanHandleLinesBloomBuffer = tanHandleLinesPreciseBloomBuffer
            tanHandleLinesUnselectedStrokeBuffer = tanHandleLinesUnselectedPreciseStrokeBuffer
            tanHandleLinesUnselectedFillBuffer = tanHandleLinesUnselectedPreciseFillBuffer
            tanHandleLinesSelectedStrokeBuffer = tanHandleLinesSelectedPreciseStrokeBuffer
            tanHandleLinesSelectedFillBuffer = tanHandleLinesSelectedPreciseFillBuffer
            
            tanHandlePointsUnselectedBloomBuffer = tanHandlePointsUnselectedPreciseBloomBuffer
            tanHandlePointsUnselectedStrokeBuffer = tanHandlePointsUnselectedPreciseStrokeBuffer
            tanHandlePointsUnselectedFillBuffer = tanHandlePointsUnselectedPreciseFillBuffer
            
            tanHandlePointsSelectedBloomBuffer = tanHandlePointsSelectedPreciseBloomBuffer
            tanHandlePointsSelectedStrokeBuffer = tanHandlePointsSelectedPreciseStrokeBuffer
            tanHandlePointsSelectedFillBuffer = tanHandlePointsSelectedPreciseFillBuffer
            
        } else {
            
            pointsUnselectedBloomBuffer = pointsUnselectedRegularBloomBuffer
            pointsUnselectedUnmodifiedStrokeBuffer = pointsUnselectedUnmodifiedRegularStrokeBuffer
            pointsUnselectedUnmodifiedFillBuffer = pointsUnselectedUnmodifiedRegularFillBuffer
            pointsUnselectedModifiedStrokeBuffer = pointsUnselectedModifiedRegularStrokeBuffer
            pointsUnselectedModifiedFillBuffer = pointsUnselectedModifiedRegularFillBuffer
            
            pointsSelectedBloomBuffer = pointsSelectedRegularBloomBuffer
            pointsSelectedStrokeBuffer = pointsSelectedRegularStrokeBuffer
            pointsSelectedFillBuffer = pointsSelectedRegularFillBuffer
            
            tanHandleLinesBloomBuffer = tanHandleLinesRegularBloomBuffer
            tanHandleLinesUnselectedStrokeBuffer = tanHandleLinesUnselectedRegularStrokeBuffer
            tanHandleLinesUnselectedFillBuffer = tanHandleLinesUnselectedRegularFillBuffer
            tanHandleLinesSelectedStrokeBuffer = tanHandleLinesSelectedRegularStrokeBuffer
            tanHandleLinesSelectedFillBuffer = tanHandleLinesSelectedRegularFillBuffer
            
            tanHandlePointsUnselectedBloomBuffer = tanHandlePointsUnselectedRegularBloomBuffer
            tanHandlePointsUnselectedStrokeBuffer = tanHandlePointsUnselectedRegularStrokeBuffer
            tanHandlePointsUnselectedFillBuffer = tanHandlePointsUnselectedRegularFillBuffer
            tanHandlePointsSelectedBloomBuffer = tanHandlePointsSelectedRegularBloomBuffer
            tanHandlePointsSelectedStrokeBuffer = tanHandlePointsSelectedRegularStrokeBuffer
            tanHandlePointsSelectedFillBuffer = tanHandlePointsSelectedRegularFillBuffer
        }
        
        // 2.) The Guide Outline
        if renderInfo.isShowingGuideBorderRings {
            if isPrecisePass {
                if isBloomMode && renderInfo.isShowingGuideBorderRingsBloom {
                    solidLineBufferPreciseBloom.shapeBuffer.projectionMatrix = projectionMatrix
                }
                solidLineBufferPreciseStroke.shapeBuffer.projectionMatrix = projectionMatrix
                solidLineBufferPreciseFill.shapeBuffer.projectionMatrix = projectionMatrix
            } else {
                if isBloomMode && renderInfo.isShowingGuideBorderRingsBloom {
                    solidLineBufferRegularBloom.shapeBuffer.projectionMatrix = projectionMatrix
                }
                solidLineBufferRegularStroke.shapeBuffer.projectionMatrix = projectionMatrix
                solidLineBufferRegularFill.shapeBuffer.projectionMatrix = projectionMatrix
            }
        }
        
        // 3.) The Jiggle Points
        preparePoints(renderInfo: renderInfo,
                      guideControlPoints: guideControlPoints,
                      guideControlPointCount: guideControlPointCount,
                      pointsUnselectedBloomBuffer: pointsUnselectedBloomBuffer,
                      pointsUnselectedUnmodifiedStrokeBuffer: pointsUnselectedUnmodifiedStrokeBuffer,
                      pointsUnselectedUnmodifiedFillBuffer: pointsUnselectedUnmodifiedFillBuffer,
                      pointsUnselectedModifiedStrokeBuffer: pointsUnselectedModifiedStrokeBuffer,
                      pointsUnselectedModifiedFillBuffer: pointsUnselectedModifiedFillBuffer,
                      pointsSelectedBloomBuffer: pointsSelectedBloomBuffer,
                      pointsSelectedStrokeBuffer: pointsSelectedStrokeBuffer,
                      pointsSelectedFillBuffer: pointsSelectedFillBuffer,
                      isPrecisePass: isPrecisePass,
                      graphicsWidth: graphicsWidth,
                      graphicsHeight: graphicsHeight)
        
        // 4.) The Jiggle Tan Lines
        prepareTanLines(renderInfo: renderInfo,
                        guideControlPoints: guideControlPoints,
                        guideControlPointCount: guideControlPointCount,
                        tanHandleLinesBloomBuffer: tanHandleLinesBloomBuffer,
                        tanHandleLinesUnselectedStrokeBuffer: tanHandleLinesUnselectedStrokeBuffer,
                        tanHandleLinesUnselectedFillBuffer: tanHandleLinesUnselectedFillBuffer,
                        tanHandleLinesSelectedStrokeBuffer: tanHandleLinesSelectedStrokeBuffer,
                        tanHandleLinesSelectedFillBuffer: tanHandleLinesSelectedFillBuffer,
                        isPrecisePass: isPrecisePass)
        
        // 5.) The Jiggle Tan Points
        prepareTanPoints(renderInfo: renderInfo,
                         guideControlPoints: guideControlPoints,
                         guideControlPointCount: guideControlPointCount,
                         tanHandlePointsUnselectedBloomBuffer: tanHandlePointsUnselectedBloomBuffer,
                         tanHandlePointsUnselectedStrokeBuffer: tanHandlePointsUnselectedStrokeBuffer,
                         tanHandlePointsUnselectedFillBuffer: tanHandlePointsUnselectedFillBuffer,
                         tanHandlePointsSelectedBloomBuffer: tanHandlePointsSelectedBloomBuffer,
                         tanHandlePointsSelectedStrokeBuffer: tanHandlePointsSelectedStrokeBuffer,
                         tanHandlePointsSelectedFillBuffer: tanHandlePointsSelectedFillBuffer,
                         isPrecisePass: isPrecisePass,
                         graphicsWidth: graphicsWidth,
                         graphicsHeight: graphicsHeight)
    }
    
    public func refreshPoints(circleSpriteFactory: CircleSpriteFactory) {
        
        
        let lineThicknessType = LinePointSizes.userLineThicknessType
        let pointSizeType = LinePointSizes.userPointSizeType
        let sizeFillUnselected = LinePointSizes.getPointFillBase(lineThicknessType: lineThicknessType,
                                                                 pointSizeType: pointSizeType,
                                                                 isSelected: false,
                                                                 isPad: Device.isPad)
        let sizeStrokeUnselected = LinePointSizes.getPointStrokeBase(lineThicknessType: lineThicknessType,
                                                                     pointSizeType: pointSizeType,
                                                                     isSelected: false,
                                                                     isPad: Device.isPad)
        let sizeFillSelected = LinePointSizes.getPointFillBase(lineThicknessType: lineThicknessType,
                                                               pointSizeType: pointSizeType,
                                                               isSelected: true,
                                                               isPad: Device.isPad)
        let sizeStrokeSelected = LinePointSizes.getPointStrokeBase(lineThicknessType: lineThicknessType,
                                                                   pointSizeType: pointSizeType,
                                                                   isSelected: true,
                                                                   isPad: Device.isPad)
        
        let unselectedFillSprite = circleSpriteFactory.circle(size: sizeFillUnselected)
        let unselectedStrokeSprite = circleSpriteFactory.circle(size: sizeStrokeUnselected)
        let selectedFillSprite = circleSpriteFactory.circle(size: sizeFillSelected)
        let selectedStrokeSprite = circleSpriteFactory.circle(size: sizeStrokeSelected)
        
        pointsUnselectedRegularBloomBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedUnmodifiedRegularStrokeBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedUnmodifiedRegularFillBuffer.sprite = unselectedFillSprite
        pointsUnselectedModifiedRegularStrokeBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedModifiedRegularFillBuffer.sprite = unselectedFillSprite
        
        pointsUnselectedPreciseBloomBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedUnmodifiedPreciseStrokeBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedUnmodifiedPreciseFillBuffer.sprite = unselectedFillSprite
        pointsUnselectedModifiedPreciseStrokeBuffer.sprite = unselectedStrokeSprite
        pointsUnselectedModifiedPreciseFillBuffer.sprite = unselectedFillSprite
        
        pointsSelectedRegularBloomBuffer.sprite = selectedStrokeSprite
        pointsSelectedRegularStrokeBuffer.sprite = selectedStrokeSprite
        pointsSelectedRegularFillBuffer.sprite = selectedFillSprite
        pointsSelectedPreciseBloomBuffer.sprite = selectedStrokeSprite
        pointsSelectedPreciseStrokeBuffer.sprite = selectedStrokeSprite
        pointsSelectedPreciseFillBuffer.sprite = selectedFillSprite
        
        tanHandlePointsUnselectedRegularBloomBuffer.sprite = unselectedStrokeSprite
        tanHandlePointsUnselectedRegularStrokeBuffer.sprite = unselectedStrokeSprite
        tanHandlePointsUnselectedRegularFillBuffer.sprite = unselectedFillSprite
        
        tanHandlePointsUnselectedPreciseBloomBuffer.sprite = unselectedStrokeSprite
        tanHandlePointsUnselectedPreciseStrokeBuffer.sprite = unselectedStrokeSprite
        tanHandlePointsUnselectedPreciseFillBuffer.sprite = unselectedFillSprite
        
        tanHandlePointsSelectedRegularBloomBuffer.sprite = selectedStrokeSprite
        tanHandlePointsSelectedRegularStrokeBuffer.sprite = selectedStrokeSprite
        tanHandlePointsSelectedRegularFillBuffer.sprite = selectedFillSprite
        
        tanHandlePointsSelectedPreciseBloomBuffer.sprite = selectedStrokeSprite
        tanHandlePointsSelectedPreciseStrokeBuffer.sprite = selectedStrokeSprite
        tanHandlePointsSelectedPreciseFillBuffer.sprite = selectedFillSprite
    }
    
    public func refreshLines(universeScaleInverse: Float) {
        let lineThicknessType = LinePointSizes.userLineThicknessType
        lineWidthFillBase = LinePointSizes.getLineThicknessFill(lineThicknessType: lineThicknessType,
                                                                isPad: Device.isPad,
                                                                universeScaleInverse: universeScaleInverse) * 0.5
        lineWidthStrokeBase = LinePointSizes.getLineThicknessStroke(lineThicknessType: lineThicknessType,
                                                                    isPad: Device.isPad,
                                                                    universeScaleInverse: universeScaleInverse) * 0.5
    }
    
    public func load(graphics: Graphics,
                     circleSpriteFactory: CircleSpriteFactory,
                     universeScaleInverse: Float) {
        
        if isLoaded {
            return
        }
        
        // Points Unselected:
        pointsUnselectedRegularBloomBuffer.load_t(graphics: graphics)
        pointsUnselectedUnmodifiedRegularStrokeBuffer.load_t(graphics: graphics)
        pointsUnselectedUnmodifiedRegularFillBuffer.load_t(graphics: graphics)
        pointsUnselectedModifiedRegularStrokeBuffer.load_t(graphics: graphics)
        pointsUnselectedModifiedRegularFillBuffer.load_t(graphics: graphics)
        
        pointsUnselectedPreciseBloomBuffer.load_t(graphics: graphics)
        pointsUnselectedUnmodifiedPreciseStrokeBuffer.load_t(graphics: graphics)
        pointsUnselectedUnmodifiedPreciseFillBuffer.load_t(graphics: graphics)
        pointsUnselectedModifiedPreciseStrokeBuffer.load_t(graphics: graphics)
        pointsUnselectedModifiedPreciseFillBuffer.load_t(graphics: graphics)
        
        // Points Selected:
        pointsSelectedRegularBloomBuffer.load_t(graphics: graphics)
        pointsSelectedRegularStrokeBuffer.load_t(graphics: graphics)
        pointsSelectedRegularFillBuffer.load_t(graphics: graphics)
        pointsSelectedPreciseBloomBuffer.load_t(graphics: graphics)
        pointsSelectedPreciseStrokeBuffer.load_t(graphics: graphics)
        pointsSelectedPreciseFillBuffer.load_t(graphics: graphics)
        
        // Tan Lines Unselected:
        tanHandleLinesRegularBloomBuffer.load_t_n(graphics: graphics)
        tanHandleLinesUnselectedRegularStrokeBuffer.load_t_n(graphics: graphics)
        tanHandleLinesUnselectedRegularFillBuffer.load_t_n(graphics: graphics)
        
        tanHandleLinesPreciseBloomBuffer.load_t_n(graphics: graphics)
        tanHandleLinesUnselectedPreciseStrokeBuffer.load_t_n(graphics: graphics)
        tanHandleLinesUnselectedPreciseFillBuffer.load_t_n(graphics: graphics)
        
        // Tan Lines Selected:
        tanHandleLinesSelectedRegularStrokeBuffer.load_t_n(graphics: graphics)
        tanHandleLinesSelectedRegularFillBuffer.load_t_n(graphics: graphics)
        
        tanHandleLinesSelectedPreciseStrokeBuffer.load_t_n(graphics: graphics)
        tanHandleLinesSelectedPreciseFillBuffer.load_t_n(graphics: graphics)
        
        // Tan Points Unselected:
        tanHandlePointsUnselectedRegularBloomBuffer.load_t(graphics: graphics)
        tanHandlePointsUnselectedRegularStrokeBuffer.load_t(graphics: graphics)
        tanHandlePointsUnselectedRegularFillBuffer.load_t(graphics: graphics)
        
        tanHandlePointsUnselectedPreciseBloomBuffer.load_t(graphics: graphics)
        tanHandlePointsUnselectedPreciseStrokeBuffer.load_t(graphics: graphics)
        tanHandlePointsUnselectedPreciseFillBuffer.load_t(graphics: graphics)
        
        // Tan Points Selected:
        tanHandlePointsSelectedRegularBloomBuffer.load_t(graphics: graphics)
        tanHandlePointsSelectedRegularStrokeBuffer.load_t(graphics: graphics)
        tanHandlePointsSelectedRegularFillBuffer.load_t(graphics: graphics)
        
        tanHandlePointsSelectedPreciseBloomBuffer.load_t(graphics: graphics)
        tanHandlePointsSelectedPreciseStrokeBuffer.load_t(graphics: graphics)
        tanHandlePointsSelectedPreciseFillBuffer.load_t(graphics: graphics)
        
        
        isLoaded = true
        
        refreshLines(universeScaleInverse: universeScaleInverse)
        refreshPoints(circleSpriteFactory: circleSpriteFactory)
    }
    
}
