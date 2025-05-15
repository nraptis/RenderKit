//
//  RenderControlPoint.swift
//  RenderKit
//
//  Created by Nicholas Raptis on 5/13/25.
//

import Foundation
import TypeKit
import MathKit

public protocol RenderControlPoint: AnyObject {
    
    var x: Float { get }
    var y: Float { get }
    
    var tanDirectionIn: Float { get }
    var tanDirectionOut: Float { get }
    
    var tanMagnitudeIn: Float { get }
    var tanMagnitudeOut: Float { get }
    
    var isManualTanHandleEnabledIn: Bool { get }
    var isManualTanHandleEnabledOut: Bool { get }
    
    var renderX: Float { get set }
    var renderY: Float { get set }
    var renderTanInX: Float { get set }
    var renderTanInY: Float { get set }
    var renderTanOutX: Float { get set }
    var renderTanOutY: Float { get set }
    var renderTanNormalInX: Float { get set }
    var renderTanNormalInY: Float { get set }
    var renderTanNormalOutX: Float { get set }
    var renderTanNormalOutY: Float { get set }
    
    var renderPointSelected: RenderPointSelectedStrategy { get set }
    
    var renderTanInSelected: Bool { get set }
    var renderTanOutSelected: Bool { get set }
    
    var point: Math.Point { get }
    
    func getTanHandleIn() -> Math.Point
    func getTanHandleOut() -> Math.Point
    
    func getTanHandleNormalsIn() -> Math.Vector
    func getTanHandleNormalsOut() -> Math.Vector
}
