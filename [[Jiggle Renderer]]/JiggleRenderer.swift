//
//  JiggleRenderer.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/13/23.
//
//  Not Verified (Mostly Verified) on 11/9/2024 by Nick Raptis
//  Major refactor on 11/24 and 11/25, 2024
//  Major refactor on 12/22 -  12/29, 2024
//

import Foundation
import Metal
import simd
import MathKit
import TypeKit

public class JiggleRenderer {
    
    var color_bloom = RGBA()
    
    var color_jiggle_center_stroke = RGBA()
    var color_jiggle_center_fill = RGBA()
    
    var color_weight_center_stroke = RGBA()
    var color_weight_center_fill = RGBA()
    
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
    
    var jiggleCenterCreatorModeFormat = JiggleCenterCreatorModeFormat.invalid
    var pointsCreatorModeFormat = PointsCreatorModeFormat.invalid
    var tansCreatorModeFormat = TansCreatorModeFormat.invalid
    var weightCenterCreatorModeFormat = WeightCenterCreatorModeFormat.invalid
    
    var isJiggleSelected = false
    public var isJiggleFrozen = false
    
    var isDarkMode = false
    var isStereoscopicMode = false
    var isBloomMode = false
    
    var isRenderingPrecise = false
    
    var orthoMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
    
    var worldScale = Float(1.0)
    
    var inverseRotation = Float(1.0)
    
    var editMode = EditMode.jiggles
    var weightMode = WeightMode.guides
    public var creatorMode = CreatorMode.none
    
    var selectedTanType = TanTypeOrNone.none
    var pointSelectionMode = PointSelectionModality.points
    
    var lineWidthFillBase = Float(8.0)
    var lineWidthStrokeBase = Float(12.0)
    
    // Jiggle Center Marker Unselected:
    let jiggleCenterMarkerUnselectedRegularStrokeInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerUnselectedRegularFillInstance = IndexedSpriteInstance2D()
    
    let jiggleCenterMarkerUnselectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerUnselectedPreciseFillInstance = IndexedSpriteInstance2D()
    
    // Jiggle Center Marker Selected:
    let jiggleCenterMarkerSelectedRegularBloomInstance = IndexedSpriteInstance3D()
    let jiggleCenterMarkerSelectedRegularStrokeInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerSelectedRegularFillInstance = IndexedSpriteInstance2D()
    
    let jiggleCenterMarkerSelectedPreciseBloomInstance = IndexedSpriteInstance3D()
    let jiggleCenterMarkerSelectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let jiggleCenterMarkerSelectedPreciseFillInstance = IndexedSpriteInstance2D()
    
    // Weight Center Marker Dot Unselected:
    let weightCenterMarkerDotUnselectedRegularStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotUnselectedRegularFillInstance = IndexedSpriteInstance2D()
    
    let weightCenterMarkerDotUnselectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotUnselectedPreciseFillInstance = IndexedSpriteInstance2D()
    
    // Weight Center Marker Dot Selected:
    let weightCenterMarkerDotSelectedRegularBloomInstance = IndexedSpriteInstance3D()
    let weightCenterMarkerDotSelectedRegularStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotSelectedRegularFillInstance = IndexedSpriteInstance2D()
    
    let weightCenterMarkerDotSelectedPreciseBloomInstance = IndexedSpriteInstance3D()
    let weightCenterMarkerDotSelectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerDotSelectedPreciseFillInstance = IndexedSpriteInstance2D()
    
    // Weight Center Marker Spinner Unselected:
    let weightCenterMarkerSpinnerUnselectedRegularStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerUnselectedRegularFillInstance = IndexedSpriteInstance2D()
    
    let weightCenterMarkerSpinnerUnselectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerUnselectedPreciseFillInstance = IndexedSpriteInstance2D()
    
    // Weight Center Marker Spinner Selected:
    let weightCenterMarkerSpinnerSelectedRegularBloomInstance = IndexedSpriteInstance3D()
    let weightCenterMarkerSpinnerSelectedRegularStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerSelectedRegularFillInstance = IndexedSpriteInstance2D()
    
    let weightCenterMarkerSpinnerSelectedPreciseBloomInstance = IndexedSpriteInstance3D()
    let weightCenterMarkerSpinnerSelectedPreciseStrokeInstance = IndexedSpriteInstance2D()
    let weightCenterMarkerSpinnerSelectedPreciseFillInstance = IndexedSpriteInstance2D()
    
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
                            jiggleControlPoints: [some RenderControlPoint],
                            jiggleControlPointCount: Int,
                            isJiggleSelected: Bool,
                            isJiggleFrozen: Bool,
                            selectedJiggleControlPointIndex: Int,
                            creatorMode: CreatorMode,
                            editMode: EditMode,
                            weightMode: WeightMode,
                            selectedTanType: TanTypeOrNone,
                            pointSelectionMode: PointSelectionModality,
                            isBloomMode: Bool,
                            jiggleCenter: Math.Point,
                            jiggleScale: Float,
                            jiggleRotation: Float,
                            graphicsWidth: Float,
                            graphicsHeight: Float) {
        
        orthoMatrix.ortho(width: graphicsWidth,
                          height: graphicsHeight)
        
        self.isJiggleSelected = isJiggleSelected
        self.isJiggleFrozen = isJiggleFrozen
        self.isDarkMode = renderInfo.isShowingDarkMode
        self.isStereoscopicMode = renderInfo.isShowingMeshViewStereoscopic
        self.creatorMode = creatorMode
        self.editMode = editMode
        self.weightMode = weightMode
        self.selectedTanType = selectedTanType
        self.pointSelectionMode = pointSelectionMode
        self.isBloomMode = isBloomMode
        
        jiggleCenterCreatorModeFormat = getJiggleCenterCreatorModeFormat(creatorMode: creatorMode)
        weightCenterCreatorModeFormat = getWeightCenterCreatorModeFormat(creatorMode: creatorMode)
        pointsCreatorModeFormat = getPointsCreatorModeFormat(creatorMode: creatorMode)
        tansCreatorModeFormat = getTansCreatorModeFormat(creatorMode: creatorMode)
        
        color_bloom = RTJ.bloom(isDarkMode: isDarkMode)
        pre_prepareJiggleCenter(renderInfo: renderInfo)
        pre_prepareWeightCenter(renderInfo: renderInfo)
        pre_preparePoints(renderInfo: renderInfo)
        pre_prepareTanLines(renderInfo: renderInfo)
        pre_prepareTanPoints(renderInfo: renderInfo)
        
        // Anything we can compute once, we will do outside of the 2 renderings...
        if renderInfo.isShowingJigglePoints {
            let isAbleToShowSelectedPoint: RenderPointSelectedStrategy
            let isAbleToShowSelectedTan: Bool
            
            if isJiggleFrozen {
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
            
            for jiggleControlPointIndex in 0..<jiggleControlPointCount {
                let jiggleControlPoint = jiggleControlPoints[jiggleControlPointIndex]
                
                var renderPoint = jiggleControlPoint.point
                renderPoint = Math.transformPoint(point: renderPoint,
                                                  translation: jiggleCenter,
                                                  scale: jiggleScale,
                                                  rotation: jiggleRotation)
                
                
                let isPointSelected: RenderPointSelectedStrategy
                
                switch isAbleToShowSelectedPoint {
                case .ignore:
                    isPointSelected = RenderPointSelectedStrategy.ignore
                case .unselected:
                    if isJiggleSelected == true {
                        if selectedJiggleControlPointIndex == jiggleControlPointIndex {
                            isPointSelected = RenderPointSelectedStrategy.unselected
                        } else {
                            isPointSelected = RenderPointSelectedStrategy.ignore
                        }
                    } else {
                        isPointSelected = RenderPointSelectedStrategy.ignore
                    }
                case .selected:
                    if isJiggleSelected == true {
                        if selectedJiggleControlPointIndex == jiggleControlPointIndex {
                            isPointSelected = RenderPointSelectedStrategy.selected
                        } else {
                            isPointSelected = RenderPointSelectedStrategy.ignore
                        }
                    } else {
                        isPointSelected = RenderPointSelectedStrategy.ignore
                    }
                }
                
                jiggleControlPoint.renderX = renderPoint.x
                jiggleControlPoint.renderY = renderPoint.y
                jiggleControlPoint.renderPointSelected = isPointSelected
                
                var isTanInSelected = false
                var isTanOutSelected = false
                if isAbleToShowSelectedTan {
                    if isJiggleSelected == true {
                        if selectedJiggleControlPointIndex == jiggleControlPointIndex {
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
                
                jiggleControlPoint.renderTanInSelected = isTanInSelected
                jiggleControlPoint.renderTanOutSelected = isTanOutSelected
                
            }
        }
        
        // Anything we can compute once, we will do outside of the 2 renderings...
        if renderInfo.isShowingJiggleControlPointTanHandles {
            for jiggleControlPointIndex in 0..<jiggleControlPointCount {
                let jiggleControlPoint = jiggleControlPoints[jiggleControlPointIndex]
                
                var tanHandleIn = jiggleControlPoint.getTanHandleIn()
                tanHandleIn = Math.transformPoint(point: tanHandleIn,
                                                  translation: jiggleCenter,
                                                  scale: jiggleScale,
                                                  rotation: jiggleRotation)
                
                jiggleControlPoint.renderTanInX = tanHandleIn.x
                jiggleControlPoint.renderTanInY = tanHandleIn.y
                
                var tanHandleOut = jiggleControlPoint.getTanHandleOut()
                tanHandleOut = Math.transformPoint(point: tanHandleOut,
                                                   translation: jiggleCenter,
                                                   scale: jiggleScale,
                                                   rotation: jiggleRotation)
                
                jiggleControlPoint.renderTanOutX = tanHandleOut.x
                jiggleControlPoint.renderTanOutY = tanHandleOut.y
                
                var tanNormalsIn = jiggleControlPoint.getTanHandleNormalsIn()
                tanNormalsIn = Math.transformVector(vector: tanNormalsIn,
                                                    scale: 1.0,
                                                    rotation: jiggleRotation)
                
                
                jiggleControlPoint.renderTanNormalInX = tanNormalsIn.x
                jiggleControlPoint.renderTanNormalInY = tanNormalsIn.y
                
                var tanNormalsOut = jiggleControlPoint.getTanHandleNormalsOut()
                tanNormalsOut = Math.transformVector(vector: tanNormalsOut,
                                                     scale: 1.0,
                                                     rotation: jiggleRotation)
                
                jiggleControlPoint.renderTanNormalOutX = tanNormalsOut.x
                jiggleControlPoint.renderTanNormalOutY = tanNormalsOut.y
            }
        }
    }
    
    // We load up all the buffers for the render, this does not render anything...
    public func prepare(renderInfo: JiggleRenderInfo,
                        jiggleControlPoints: [some RenderControlPoint],
                        jiggleControlPointCount: Int,
                        editBufferStandardRegular: IndexedShapeBuffer2DColored,
                        editBufferWeightsRegular: IndexedShapeBuffer2DColored,
                        editBufferStandardPrecise: IndexedShapeBuffer2DColored,
                        editBufferWeightsPrecise: IndexedShapeBuffer2DColored,
                        viewBuffer: IndexedSpriteBuffer3D,
                        viewBufferStereoscopic: IndexedSpriteBuffer3DStereoscopic,
                        solidLineBufferPreciseBloom: SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferPreciseStroke: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferPreciseFill: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferRegularBloom: SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferRegularStroke: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        solidLineBufferRegularFill: SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>,
                        projectionMatrix: matrix_float4x4,
                        isPrecisePass: Bool,
                        isRenderingPrecise: Bool,
                        jiggleCenter: Math.Point,
                        jiggleScale: Float,
                        jiggleRotation: Float,
                        guideCenter: Math.Point,
                        guideCenterSpinnerRotation: Float,
                        offsetCenter: Math.Point,
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
        
        let jiggleCenterMarkerUnselectedStrokeInstance: IndexedSpriteInstance2D
        let jiggleCenterMarkerUnselectedFillInstance: IndexedSpriteInstance2D
        let jiggleCenterMarkerSelectedBloomInstance: IndexedSpriteInstance3D
        let jiggleCenterMarkerSelectedStrokeInstance: IndexedSpriteInstance2D
        let jiggleCenterMarkerSelectedFillInstance: IndexedSpriteInstance2D
        
        let weightCenterMarkerDotUnselectedStrokeInstance: IndexedSpriteInstance2D
        let weightCenterMarkerDotUnselectedFillInstance: IndexedSpriteInstance2D
        let weightCenterMarkerDotSelectedBloomInstance: IndexedSpriteInstance3D
        let weightCenterMarkerDotSelectedStrokeInstance: IndexedSpriteInstance2D
        let weightCenterMarkerDotSelectedFillInstance: IndexedSpriteInstance2D
        
        let weightCenterMarkerSpinnerUnselectedStrokeInstance: IndexedSpriteInstance2D
        let weightCenterMarkerSpinnerUnselectedFillInstance: IndexedSpriteInstance2D
        let weightCenterMarkerSpinnerSelectedBloomInstance: IndexedSpriteInstance3D
        let weightCenterMarkerSpinnerSelectedStrokeInstance: IndexedSpriteInstance2D
        let weightCenterMarkerSpinnerSelectedFillInstance: IndexedSpriteInstance2D
        
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
            
            jiggleCenterMarkerUnselectedStrokeInstance = jiggleCenterMarkerUnselectedPreciseStrokeInstance
            jiggleCenterMarkerUnselectedFillInstance = jiggleCenterMarkerUnselectedPreciseFillInstance
            
            jiggleCenterMarkerSelectedBloomInstance = jiggleCenterMarkerSelectedPreciseBloomInstance
            jiggleCenterMarkerSelectedStrokeInstance = jiggleCenterMarkerSelectedPreciseStrokeInstance
            jiggleCenterMarkerSelectedFillInstance = jiggleCenterMarkerSelectedPreciseFillInstance
            
            weightCenterMarkerDotUnselectedStrokeInstance = weightCenterMarkerDotUnselectedPreciseStrokeInstance
            weightCenterMarkerDotUnselectedFillInstance = weightCenterMarkerDotUnselectedPreciseFillInstance
            
            weightCenterMarkerDotSelectedBloomInstance = weightCenterMarkerDotSelectedPreciseBloomInstance
            weightCenterMarkerDotSelectedStrokeInstance = weightCenterMarkerDotSelectedPreciseStrokeInstance
            weightCenterMarkerDotSelectedFillInstance = weightCenterMarkerDotSelectedPreciseFillInstance
            
            weightCenterMarkerSpinnerUnselectedStrokeInstance = weightCenterMarkerSpinnerUnselectedPreciseStrokeInstance
            weightCenterMarkerSpinnerUnselectedFillInstance = weightCenterMarkerSpinnerUnselectedPreciseFillInstance
            
            weightCenterMarkerSpinnerSelectedBloomInstance = weightCenterMarkerSpinnerSelectedPreciseBloomInstance
            weightCenterMarkerSpinnerSelectedStrokeInstance = weightCenterMarkerSpinnerSelectedPreciseStrokeInstance
            weightCenterMarkerSpinnerSelectedFillInstance = weightCenterMarkerSpinnerSelectedPreciseFillInstance
            
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
            
            jiggleCenterMarkerUnselectedStrokeInstance = jiggleCenterMarkerUnselectedRegularStrokeInstance
            jiggleCenterMarkerUnselectedFillInstance = jiggleCenterMarkerUnselectedRegularFillInstance
            
            jiggleCenterMarkerSelectedBloomInstance = jiggleCenterMarkerSelectedRegularBloomInstance
            jiggleCenterMarkerSelectedStrokeInstance = jiggleCenterMarkerSelectedRegularStrokeInstance
            jiggleCenterMarkerSelectedFillInstance = jiggleCenterMarkerSelectedRegularFillInstance
            
            weightCenterMarkerDotUnselectedStrokeInstance = weightCenterMarkerDotUnselectedRegularStrokeInstance
            weightCenterMarkerDotUnselectedFillInstance = weightCenterMarkerDotUnselectedRegularFillInstance
            
            weightCenterMarkerDotSelectedBloomInstance = weightCenterMarkerDotSelectedRegularBloomInstance
            weightCenterMarkerDotSelectedStrokeInstance = weightCenterMarkerDotSelectedRegularStrokeInstance
            weightCenterMarkerDotSelectedFillInstance = weightCenterMarkerDotSelectedRegularFillInstance
            
            weightCenterMarkerSpinnerUnselectedStrokeInstance = weightCenterMarkerSpinnerUnselectedRegularStrokeInstance
            weightCenterMarkerSpinnerUnselectedFillInstance = weightCenterMarkerSpinnerUnselectedRegularFillInstance
            
            weightCenterMarkerSpinnerSelectedBloomInstance = weightCenterMarkerSpinnerSelectedRegularBloomInstance
            weightCenterMarkerSpinnerSelectedStrokeInstance = weightCenterMarkerSpinnerSelectedRegularStrokeInstance
            weightCenterMarkerSpinnerSelectedFillInstance = weightCenterMarkerSpinnerSelectedRegularFillInstance
            
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
        
        // 1.) Main Jiggle Fill... (Note: This order has no effect, it's just a mental organization)
        if isPrecisePass {
            editBufferStandardPrecise.projectionMatrix = projectionMatrix
            editBufferWeightsPrecise.projectionMatrix = projectionMatrix
        } else {
            editBufferStandardRegular.projectionMatrix = projectionMatrix
            editBufferWeightsRegular.projectionMatrix = projectionMatrix
            viewBuffer.projectionMatrix = projectionMatrix
            viewBufferStereoscopic.projectionMatrix = projectionMatrix
        }
        
        
        // 2.) The Jiggle Outline
        if renderInfo.isShowingJiggleBorderRings {
            if isPrecisePass {
                if isBloomMode && renderInfo.isShowingJiggleBorderRingsBloom {
                    solidLineBufferPreciseBloom.shapeBuffer.projectionMatrix = projectionMatrix
                }
                solidLineBufferPreciseStroke.shapeBuffer.projectionMatrix = projectionMatrix
                solidLineBufferPreciseFill.shapeBuffer.projectionMatrix = projectionMatrix
            } else {
                if isBloomMode && renderInfo.isShowingJiggleBorderRingsBloom {
                    solidLineBufferRegularBloom.shapeBuffer.projectionMatrix = projectionMatrix
                }
                solidLineBufferRegularStroke.shapeBuffer.projectionMatrix = projectionMatrix
                solidLineBufferRegularFill.shapeBuffer.projectionMatrix = projectionMatrix
            }
        }
        
        // 3.) The Jiggle Points
        preparePoints(renderInfo: renderInfo,
                      jiggleControlPoints: jiggleControlPoints,
                      jiggleControlPointCount: jiggleControlPointCount,
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
                        jiggleControlPoints: jiggleControlPoints,
                        jiggleControlPointCount: jiggleControlPointCount,
                        tanHandleLinesBloomBuffer: tanHandleLinesBloomBuffer,
                        tanHandleLinesUnselectedStrokeBuffer: tanHandleLinesUnselectedStrokeBuffer,
                        tanHandleLinesUnselectedFillBuffer: tanHandleLinesUnselectedFillBuffer,
                        tanHandleLinesSelectedStrokeBuffer: tanHandleLinesSelectedStrokeBuffer,
                        tanHandleLinesSelectedFillBuffer: tanHandleLinesSelectedFillBuffer,
                        isPrecisePass: isPrecisePass)
        
        // 5.) The Jiggle Tan Points
        prepareTanPoints(renderInfo: renderInfo,
                         jiggleControlPoints: jiggleControlPoints,
                         jiggleControlPointCount: jiggleControlPointCount,
                         tanHandlePointsUnselectedBloomBuffer: tanHandlePointsUnselectedBloomBuffer,
                         tanHandlePointsUnselectedStrokeBuffer: tanHandlePointsUnselectedStrokeBuffer,
                         tanHandlePointsUnselectedFillBuffer: tanHandlePointsUnselectedFillBuffer,
                         tanHandlePointsSelectedBloomBuffer: tanHandlePointsSelectedBloomBuffer,
                         tanHandlePointsSelectedStrokeBuffer: tanHandlePointsSelectedStrokeBuffer,
                         tanHandlePointsSelectedFillBuffer: tanHandlePointsSelectedFillBuffer,
                         isPrecisePass: isPrecisePass,
                         graphicsWidth: graphicsWidth,
                         graphicsHeight: graphicsHeight)
        
        // 6.) The Jiggle Center Marker
        prepareJiggleCenter(renderInfo: renderInfo,
                            jiggleCenterMarkerUnselectedStrokeInstance: jiggleCenterMarkerUnselectedStrokeInstance,
                            jiggleCenterMarkerUnselectedFillInstance: jiggleCenterMarkerUnselectedFillInstance,
                            jiggleCenterMarkerSelectedBloomInstance: jiggleCenterMarkerSelectedBloomInstance,
                            jiggleCenterMarkerSelectedStrokeInstance: jiggleCenterMarkerSelectedStrokeInstance,
                            jiggleCenterMarkerSelectedFillInstance: jiggleCenterMarkerSelectedFillInstance,
                            isPrecisePass: isPrecisePass,
                            jiggleCenter: jiggleCenter,
                            jiggleScale: jiggleScale,
                            jiggleRotation: jiggleRotation,
                            offsetCenter: offsetCenter,
                            graphicsWidth: graphicsWidth,
                            graphicsHeight: graphicsHeight)
        
        // 7.) The Weight Center Marker
        prepareWeightCenter(renderInfo: renderInfo,
                            weightCenterMarkerDotUnselectedStrokeInstance: weightCenterMarkerDotUnselectedStrokeInstance,
                            weightCenterMarkerDotUnselectedFillInstance: weightCenterMarkerDotUnselectedFillInstance,
                            weightCenterMarkerDotSelectedBloomInstance: weightCenterMarkerDotSelectedBloomInstance,
                            weightCenterMarkerDotSelectedFillInstance: weightCenterMarkerDotSelectedFillInstance,
                            weightCenterMarkerDotSelectedStrokeInstance: weightCenterMarkerDotSelectedStrokeInstance,
                            weightCenterMarkerSpinnerUnselectedStrokeInstance: weightCenterMarkerSpinnerUnselectedStrokeInstance,
                            weightCenterMarkerSpinnerUnselectedFillInstance: weightCenterMarkerSpinnerUnselectedFillInstance,
                            weightCenterMarkerSpinnerSelectedBloomInstance: weightCenterMarkerSpinnerSelectedBloomInstance,
                            weightCenterMarkerSpinnerSelectedFillInstance: weightCenterMarkerSpinnerSelectedFillInstance,
                            weightCenterMarkerSpinnerSelectedStrokeInstance: weightCenterMarkerSpinnerSelectedStrokeInstance,
                            isPrecisePass: isPrecisePass,
                            jiggleCenter: jiggleCenter,
                            jiggleScale: jiggleScale,
                            jiggleRotation: jiggleRotation,
                            guideCenter: guideCenter,
                            guideCenterSpinnerRotation: guideCenterSpinnerRotation,
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
                     
                     jiggleCenterMarkerUnselectedStroke: Sprite,
                     jiggleCenterMarkerUnselectedFill: Sprite,
                     
                     jiggleCenterMarkerSelectedStroke: Sprite,
                     jiggleCenterMarkerSelectedFill: Sprite,
                     
                     weightCenterMarkerDotUnselectedStroke: Sprite,
                     weightCenterMarkerDotUnselectedFill: Sprite,
                     
                     weightCenterMarkerDotSelectedStroke: Sprite,
                     weightCenterMarkerDotSelectedFill: Sprite,
                     
                     weightCenterMarkerSpinnerUnselectedStroke: Sprite,
                     weightCenterMarkerSpinnerUnselectedFill: Sprite,
                     
                     weightCenterMarkerSpinnerSelectedStroke: Sprite,
                     weightCenterMarkerSpinnerSelectedFill: Sprite,
                     
                     
                     universeScaleInverse: Float) {
        
        if isLoaded {
            return
        }
        
        // Jiggle Center Marker Unselected:
        jiggleCenterMarkerUnselectedRegularStrokeInstance.load(graphics: graphics, sprite: jiggleCenterMarkerUnselectedStroke)
        jiggleCenterMarkerUnselectedRegularFillInstance.load(graphics: graphics, sprite: jiggleCenterMarkerUnselectedFill)
        
        jiggleCenterMarkerUnselectedPreciseStrokeInstance.load(graphics: graphics, sprite: jiggleCenterMarkerUnselectedStroke)
        jiggleCenterMarkerUnselectedPreciseFillInstance.load(graphics: graphics, sprite: jiggleCenterMarkerUnselectedFill)
        
        // Jiggle Center Marker Selected:
        jiggleCenterMarkerSelectedRegularBloomInstance.load(graphics: graphics, sprite: jiggleCenterMarkerSelectedStroke)
        jiggleCenterMarkerSelectedRegularStrokeInstance.load(graphics: graphics, sprite: jiggleCenterMarkerSelectedStroke)
        jiggleCenterMarkerSelectedRegularFillInstance.load(graphics: graphics, sprite: jiggleCenterMarkerSelectedFill)
        
        jiggleCenterMarkerSelectedPreciseBloomInstance.load(graphics: graphics, sprite: jiggleCenterMarkerSelectedStroke)
        jiggleCenterMarkerSelectedPreciseStrokeInstance.load(graphics: graphics, sprite: jiggleCenterMarkerSelectedStroke)
        jiggleCenterMarkerSelectedPreciseFillInstance.load(graphics: graphics, sprite: jiggleCenterMarkerSelectedFill)
        
        // Weight Center Marker Dot Unselected:
        weightCenterMarkerDotUnselectedRegularStrokeInstance.load(graphics: graphics, sprite: weightCenterMarkerDotUnselectedStroke)
        weightCenterMarkerDotUnselectedRegularFillInstance.load(graphics: graphics, sprite: weightCenterMarkerDotUnselectedFill)
        
        weightCenterMarkerDotUnselectedPreciseStrokeInstance.load(graphics: graphics, sprite: weightCenterMarkerDotUnselectedStroke)
        weightCenterMarkerDotUnselectedPreciseFillInstance.load(graphics: graphics, sprite: weightCenterMarkerDotUnselectedFill)
        
        // Weight Center Marker Dot Selected:
        weightCenterMarkerDotSelectedRegularBloomInstance.load(graphics: graphics, sprite: weightCenterMarkerDotSelectedStroke)
        weightCenterMarkerDotSelectedRegularStrokeInstance.load(graphics: graphics, sprite: weightCenterMarkerDotSelectedStroke)
        weightCenterMarkerDotSelectedRegularFillInstance.load(graphics: graphics, sprite: weightCenterMarkerDotSelectedFill)
        
        weightCenterMarkerDotSelectedPreciseBloomInstance.load(graphics: graphics, sprite: weightCenterMarkerDotSelectedStroke)
        weightCenterMarkerDotSelectedPreciseStrokeInstance.load(graphics: graphics, sprite: weightCenterMarkerDotSelectedStroke)
        weightCenterMarkerDotSelectedPreciseFillInstance.load(graphics: graphics, sprite: weightCenterMarkerDotSelectedFill)
        
        // Weight Center Marker Spinner Unselected:
        weightCenterMarkerSpinnerUnselectedRegularStrokeInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerUnselectedStroke)
        weightCenterMarkerSpinnerUnselectedRegularFillInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerUnselectedFill)
        
        weightCenterMarkerSpinnerUnselectedPreciseStrokeInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerUnselectedStroke)
        weightCenterMarkerSpinnerUnselectedPreciseFillInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerUnselectedFill)
        
        // Weight Center Marker Spinner Selected:
        weightCenterMarkerSpinnerSelectedRegularBloomInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerSelectedStroke)
        weightCenterMarkerSpinnerSelectedRegularStrokeInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerSelectedStroke)
        weightCenterMarkerSpinnerSelectedRegularFillInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerSelectedFill)
        
        weightCenterMarkerSpinnerSelectedPreciseBloomInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerSelectedStroke)
        weightCenterMarkerSpinnerSelectedPreciseStrokeInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerSelectedStroke)
        weightCenterMarkerSpinnerSelectedPreciseFillInstance.load(graphics: graphics, sprite: weightCenterMarkerSpinnerSelectedFill)
        
        
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
        
        
        refreshLines(universeScaleInverse: universeScaleInverse)
        refreshPoints(circleSpriteFactory: circleSpriteFactory)
        
        isLoaded = true
        
    }
    
}
