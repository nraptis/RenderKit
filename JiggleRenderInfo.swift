//
//  JiggleRenderInfo.swift
//  RenderKit
//
//  Created by Nicholas Raptis on 5/15/25.
//

import Foundation

public class JiggleRenderInfo {
    
    public init() {
        
    }
    
    public var isShowingLocked = false
    public var isShowingMeshEditStandard = false
    public var isShowingMeshEditWeights = false
    public var isShowingMeshViewStandard = false
    public var isShowingMeshViewStereoscopic = false
    public var isShowingMeshSwivel = false
    public var isShowingCenterMarker = false
    public var isShowingCenterMarkerBloom = false
    public var isShowingJiggleBorderRings = false
    public var isShowingJiggleBorderRingsBloom = false
    public var isShowingJigglePoints = false
    public var isShowingJigglePointsBloom = false
    public var isShowingWeightCenterMarker = false
    public var isShowingWeightCenterMarkerBloom = false
    public var isShowingGuideBorderRings = false
    public var isShowingGuideBorderRingsBloom = false
    public var isShowingGuidePoints = false
    public var isShowingGuidePointsBloom = false
    public var isShowingDarkMode = false
    public var isShowingJiggleControlPointTanHandles = false
    public var isShowingGuideControlPointTanHandles = false
    public var isShowingJiggleControlPointTanHandlesBloom = false
    public var isShowingGuideControlPointTanHandlesBloom = false
    
    public func lockShowingState() {
        isShowingLocked = true
    }
    
    public func unlockShowingState() {
        isShowingLocked = false
    }
    
}
