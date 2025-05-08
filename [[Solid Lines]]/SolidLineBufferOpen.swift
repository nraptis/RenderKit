//
//  SolidLineBufferOpen.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 4/27/24.
//

import Foundation
import Metal
import simd
import MathKit

public class SolidLineBufferOpen {
    
    public init() {
        
    }

    public let shapeBuffer = IndexedShapeBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>()
    
    public private(set) var capacity = 0
    public private(set) var count = 0
    public var thickness = Float(10.0)
    
    public var red = Float(1.0)
    public var green = Float(1.0)
    public var blue = Float(1.0)
    
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
    
    func reserveCapacity(minimumCapacity: Int) {
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
        
        let lineWidth = thickness * scale
        
        shapeBuffer.reset()
        
        guard count > 1 else {
            return
        }
        
        var previousX = _x[0]
        var previousY = _y[0]
        
        var bufferIndex = UInt32(0)
        
        var currentX = Float(0.0)
        var currentY = Float(0.0)
        
        
        var dirX = Float(0.0)
        var dirY = Float(0.0)
        
        var length = Float(0.0)
        
        var previousX2 = Float(0.0)
        var previousY2 = Float(0.0)
        var previousX4 = Float(0.0)
        var previousY4 = Float(0.0)
        
        var didWriteAtLeastOnce = false
        
        var index = 1
        while index < count {
            
            currentX = _x[index]
            currentY = _y[index]
            
            dirX = currentX - previousX
            dirY = currentY - previousY
            length = dirX * dirX + dirY * dirY
            if length <= MathKit.Math.epsilon {
                index += 1
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
            
            let vertex1 = Shape2DVertex(x: x1, y: y1)
            let vertex2 = Shape2DVertex(x: x2, y: y2)
            let vertex3 = Shape2DVertex(x: x3, y: y3)
            let vertex4 = Shape2DVertex(x: x4, y: y4)
            
            bufferIndex = shapeBuffer.addTriangleQuad(startingAt: bufferIndex,
                                                      vertex1: vertex1,
                                                      vertex2: vertex2,
                                                      vertex3: vertex3,
                                                      vertex4: vertex4)
            
            if didWriteAtLeastOnce {
                
                if MathKit.Math.triangleIsClockwise(x1: previousX2, y1: previousY2,
                                            x2: x3, y2: y3,
                                            x3: x1, y3: y1) {
                    
                    let nodeA = Shape2DVertex(x: previousX2, y: previousY2)
                    let nodeB = Shape2DVertex(x: x1, y: y1)
                    let nodeC = Shape2DVertex(x: x3, y: y3)
                    
                    shapeBuffer.add(vertex: nodeA)
                    shapeBuffer.add(vertex: nodeB)
                    shapeBuffer.add(vertex: nodeC)
                    
                    bufferIndex = shapeBuffer.addTriangle(startingAt: bufferIndex)
                    
                } else {
                    
                    let nodeA = Shape2DVertex(x: previousX4, y: previousY4)
                    let nodeB = Shape2DVertex(x: x1, y: y1)
                    let nodeC = Shape2DVertex(x: x3, y: y3)
                    
                    shapeBuffer.add(vertex: nodeA)
                    shapeBuffer.add(vertex: nodeB)
                    shapeBuffer.add(vertex: nodeC)
                    
                    bufferIndex = shapeBuffer.addTriangle(startingAt: bufferIndex)
                }
            }
            
            previousX = currentX
            previousY = currentY
            previousX2 = x2
            previousY2 = y2
            previousX4 = x4
            previousY4 = y4
            
            didWriteAtLeastOnce = true
            
            index += 1
        }
    }
    
    public func render(renderEncoder: MTLRenderCommandEncoder) {
        shapeBuffer.uniformsFragment.red = red
        shapeBuffer.uniformsFragment.green = green
        shapeBuffer.uniformsFragment.blue = blue
        shapeBuffer.setDirty(isVertexBufferDirty: true,
                             isIndexBufferDirty: true,
                             isUniformsVertexBufferDirty: true,
                             isUniformsFragmentBufferDirty: true)
        shapeBuffer.render(renderEncoder: renderEncoder, pipelineState: .shapeNodeIndexed2DAlphaBlending)
    }
    
}
