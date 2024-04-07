//
//  PrimaryButtonStyle.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(configuration.isPressed ? Color.accentColor.opacity(0.75) : Color.accentColor)
            .foregroundStyle(.white)
            .clipShape(.buttonBorder)
    }
}
