//
//  DashboardSection.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 08/04/24.
//

import SwiftUI

struct DashboardSection<Content, HeaderTrailing>: View where Content: View, HeaderTrailing: View {
    var title: LocalizedStringKey
    var headerTrailing: () -> HeaderTrailing
    var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                headerTrailing()
                    .frame(alignment: .trailing)
            }
            .padding()
            content()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    init(title: LocalizedStringKey, @ViewBuilder headerTrailing: @escaping () -> HeaderTrailing, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.headerTrailing = headerTrailing
        self.content = content
    }
    
    init(title: LocalizedStringKey, @ViewBuilder content: @escaping () -> Content) where HeaderTrailing == EmptyView {
        self.init(title: title, headerTrailing: {
            EmptyView()
        }, content: content)
    }
}

#Preview {
    DashboardSection(title: "Header") {
        Text("Content")
    }
}
