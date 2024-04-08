//
//  SplitCardShape.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 07/04/24.
//

import SwiftUI

struct SplitCardShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        return path
    }
}

#Preview {
    Rectangle()
        .fill(.blue)
        .overlay {
            SplitCardShape()
                .fill(.red)
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
}
