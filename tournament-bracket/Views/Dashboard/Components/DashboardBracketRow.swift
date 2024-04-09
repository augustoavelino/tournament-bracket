//
//  DashboardBracketRow.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import SwiftUI

struct DashboardBracketRow: View {
    var title: String
    
    var body: some View {
        VStack(spacing: 8.0) {
            HStack(alignment: .center, spacing: 16.0) {
                Image(systemName: "trophy.circle")
                    .resizable()
                    .frame(width: 28.0, height: 28.0)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.primary, .orange)
                Text(title)
                    .font(.title2)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding(8.0)
            .frame(height: 48.0)
        }
        .background()
    }
}

#Preview {
    Group {
        DashboardBracketRow(title: "Test")
        DashboardBracketRow(title: "Other")
        DashboardBracketRow(title: "Another")
    }
}
