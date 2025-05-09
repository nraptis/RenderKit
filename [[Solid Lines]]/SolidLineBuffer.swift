//
//  SolidLineBuffer.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 3/11/24.
//

import Foundation
import Metal
import simd
import MathKit
    
public class SolidLineBuffer<Node: PositionConforming2D,
                      VertexUniforms: UniformsVertex,
                      FragmentUniforms: UniformsFragment> {

    public let shapeBuffer = IndexedShapeBuffer<Node, VertexUniforms, FragmentUniforms>()
    
    public private(set) var capacity = 0
    public private(set) var count = 0
    public var thickness = Float(10.0)
    private var sentinelNode: Node
    public init(sentinelNode: Node) {
        self.sentinelNode = sentinelNode
    }
    
    public var rgba: RGBA {
        get {
            RGBA(red: shapeBuffer.red,
                 green: shapeBuffer.green,
                 blue: shapeBuffer.blue,
                 alpha: shapeBuffer.alpha)
        }
        
        set {
            shapeBuffer.red = newValue.red
            shapeBuffer.green = newValue.green
            shapeBuffer.blue = newValue.blue
            shapeBuffer.alpha = newValue.alpha
        }
    }
    
    public var red: Float {
        get {
            shapeBuffer.red
        }
        set {
            shapeBuffer.red = newValue
        }
    }
    public var green: Float {
        get {
            shapeBuffer.green
        }
        set {
            shapeBuffer.green = newValue
        }
    }
    public var blue: Float {
        get {
            shapeBuffer.blue
        }
        set {
            shapeBuffer.blue = newValue
        }
    }
    
    public var _x = [Float]()
    public var _y = [Float]()
    
    public func load(graphics: Graphics?) {
        if let graphics = graphics {
            shapeBuffer.load(graphics: graphics)
        }
        shapeBuffer.primitiveType = .triangle
        shapeBuffer.cullMode = .none
    }
    
    public func addPoint(_ x: Float, _ y: Float) {
        if count >= capacity {
            reserveCapacity(minimumCapacity: count + (count >> 1) + 1)
        }
        _x[count] = x
        _y[count] = y
        count += 1
    }
    
    public func reserveCapacity(minimumCapacity: Int) {
        if minimumCapacity > capacity {
            
            _x.reserveCapacity(minimumCapacity)
            _y.reserveCapacity(minimumCapacity)

            while _x.count < minimumCapacity { _x.append(0.0) }
            while _y.count < minimumCapacity { _y.append(0.0) }
            capacity = minimumCapacity
        }
    }
    
    public func removeAll(keepingCapacity: Bool) {
        shapeBuffer.reset()
        if keepingCapacity == false {
            _x.removeAll(keepingCapacity: false)
            _y.removeAll(keepingCapacity: false)
            capacity = 0
        }
        count = 0
    }
    
    public func generate(scale: Float) {
        
        let lineWidth = (thickness * 0.5) * scale
        
        shapeBuffer.reset()
        guard count > 1 else {
            return
        }
        
        var previousX = _x[count - 1]
        var previousY = _y[count - 1]
        var previousValid = false
        var bufferIndex = UInt32(0)
        
        var currentX = _x[count - 2]
        var currentY = _y[count - 2]
        
        var dirX = previousX - currentX
        var dirY = previousY - currentY
        
        var length = dirX * dirX + dirY * dirY
        
        var previousX2 = previousX
        var previousY2 = previousY
        var previousX4 = previousX
        var previousY4 = previousY
        
        if length > Math.epsilon {
            previousValid = true
            
            length = sqrtf(length)
            dirX /= length
            dirY /= length
            
            let hold = dirX
            dirX = dirY * (-lineWidth)
            dirY = hold * lineWidth
            
            previousX2 = previousX - dirX
            previousY2 = previousY - dirY
            
            previousX4 = previousX + dirX
            previousY4 = previousY + dirY
        }
        
        for index in 0..<count {
            currentX = _x[index]
            currentY = _y[index]
            
            dirX = currentX - previousX
            dirY = currentY - previousY
            length = dirX * dirX + dirY * dirY
            if length <= Math.epsilon {
                previousValid = false
                continue
            }
            
            length = sqrtf(length)
            dirX /= length
            dirY /= length
            
            let hold = dirX
            dirX = dirY * (-lineWidth)
            dirY = hold * lineWidth
            
            let x1 = previousX - dirX
            let y1 = previousY - dirY
            let x2 = currentX - dirX
            let y2 = currentY - dirY
            let x3 = previousX + dirX
            let y3 = previousY + dirY
            let x4 = currentX + dirX
            let y4 = currentY + dirY
            
            var vertex1 = sentinelNode
            vertex1.x = x1; vertex1.y = y1
            
            var vertex2 = sentinelNode
            vertex2.x = x2; vertex2.y = y2
            
            var vertex3 = sentinelNode
            vertex3.x = x3; vertex3.y = y3
            
            var vertex4 = sentinelNode
            vertex4.x = x4; vertex4.y = y4
            
            bufferIndex = shapeBuffer.addTriangleQuad(startingAt: bufferIndex,
                                                      vertex1: vertex1, vertex2: vertex2,
                                                      vertex3: vertex3, vertex4: vertex4)
            
            if previousValid {
                
                if Math.triangleIsClockwise(x1: previousX2, y1: previousY2,
                                            x2: x3, y2: y3,
                                            x3: x1, y3: y1) {
                    
                    var vertex1 = sentinelNode
                    vertex1.x = previousX2; vertex1.y = previousY2
                    
                    var vertex2 = sentinelNode
                    vertex2.x = x1; vertex2.y = y1
                    
                    var vertex3 = sentinelNode
                    vertex3.x = x3; vertex3.y = y3
                    
                    bufferIndex = shapeBuffer.addTriangle(startingAt: bufferIndex,
                                                          vertex1: vertex1,
                                                          vertex2: vertex2,
                                                          vertex3: vertex3)
                } else {
                    
                    var vertex1 = sentinelNode
                    vertex1.x = previousX4; vertex1.y = previousY4
                    
                    var vertex2 = sentinelNode
                    vertex2.x = x1; vertex2.y = y1
                    
                    var vertex3 = sentinelNode
                    vertex3.x = x3; vertex3.y = y3
                    
                    bufferIndex = shapeBuffer.addTriangle(startingAt: bufferIndex,
                                                          vertex1: vertex1,
                                                          vertex2: vertex2,
                                                          vertex3: vertex3)
                }
            }
            
            previousValid = true
            
            previousX = currentX
            previousY = currentY
            previousX2 = x2
            previousY2 = y2
            previousX4 = x4
            previousY4 = y4
        }
        
    }
    
    public func render(renderEncoder: MTLRenderCommandEncoder,
                pipelineState: Graphics.PipelineState) {
        
        shapeBuffer.render(renderEncoder: renderEncoder, pipelineState: pipelineState)
    }
    
}

