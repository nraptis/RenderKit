//
//  CircleSpriteFactory.swift
//  RenderKit
//
//  Created by Nicholas Raptis on 5/15/25.
//

import Foundation

public class CircleSpriteFactory {
    
    public init() {
        
    }
    
    static func _get_circle_sprite() -> [Sprite] {
        let ceiling = 22
        var result = [Sprite]()
        result.reserveCapacity(ceiling + 1)
        for _ in 0...ceiling {
            result.append(Sprite())
        }
        return result
    }
    
    let circle_sprite = CircleSpriteFactory._get_circle_sprite()
    
    public func circle(size: Int) -> Sprite {
        circle_sprite[size]
    }
    
    @MainActor public func load(graphics: Graphics) {
        circle_sprite[2].loadScaled(graphics: graphics, name: "circle_02", extension: "png")
        circle_sprite[3].loadScaled(graphics: graphics, name: "circle_03", extension: "png")
        circle_sprite[4].loadScaled(graphics: graphics, name: "circle_04", extension: "png")
        circle_sprite[5].loadScaled(graphics: graphics, name: "circle_05", extension: "png")
        circle_sprite[6].loadScaled(graphics: graphics, name: "circle_06", extension: "png")
        circle_sprite[7].loadScaled(graphics: graphics, name: "circle_07", extension: "png")
        circle_sprite[8].loadScaled(graphics: graphics, name: "circle_08", extension: "png")
        circle_sprite[9].loadScaled(graphics: graphics, name: "circle_09", extension: "png")
        circle_sprite[10].loadScaled(graphics: graphics, name: "circle_10", extension: "png")
        circle_sprite[11].loadScaled(graphics: graphics, name: "circle_11", extension: "png")
        circle_sprite[12].loadScaled(graphics: graphics, name: "circle_12", extension: "png")
        circle_sprite[13].loadScaled(graphics: graphics, name: "circle_13", extension: "png")
        circle_sprite[14].loadScaled(graphics: graphics, name: "circle_14", extension: "png")
        circle_sprite[15].loadScaled(graphics: graphics, name: "circle_15", extension: "png")
        circle_sprite[16].loadScaled(graphics: graphics, name: "circle_16", extension: "png")
        circle_sprite[17].loadScaled(graphics: graphics, name: "circle_17", extension: "png")
        circle_sprite[18].loadScaled(graphics: graphics, name: "circle_18", extension: "png")
        circle_sprite[19].loadScaled(graphics: graphics, name: "circle_19", extension: "png")
        circle_sprite[20].loadScaled(graphics: graphics, name: "circle_20", extension: "png")
        circle_sprite[21].loadScaled(graphics: graphics, name: "circle_21", extension: "png")
        circle_sprite[22].loadScaled(graphics: graphics, name: "circle_22", extension: "png")
    }
    
}
