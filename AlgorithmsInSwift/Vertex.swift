//
//  Vertex.swift
//  DSA_Easy
//
//  Created by Hadi Kheyruri on 2020-12-01.
//  Copyright © 2020 SerenaVisions Technology Inc. All rights reserved.
//

import Foundation

class Vertex: Equatable, Hashable, CustomStringConvertible {
    
    var label: String = ""
    var color: String?
    var adjacencies: Set<Vertex> = Set<Vertex>()
    var description: String { return label + ":" + (color ?? "NaN") }
    
    init(_ label: String) {
        self.label = label
    }
    
    static func == (lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.label == rhs.label && lhs.color == rhs.color
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(color)
    }
}
