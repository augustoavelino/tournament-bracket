//
//  DashboardMatchCarousel.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import SwiftUI

struct DashboardMatchCarousel: View {
    var matches: [Match] = []
    
    var body: some View {
        ZStack {
            if matches.isEmpty {
                HStack {
                    Text("No events")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: 192)
                .padding([.horizontal, .bottom])
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0.0) {
                    ForEach(matches) { match in
                        NavigationLink(value: match) {
                            DashboardMatchCard(homeCompetitor: match.homeCompetitor?.name ?? "Home", awayCompetitor: match.awayCompetitor?.name ?? "Away")
                                .containerRelativeFrame(.horizontal)
                        }
                        .buttonStyle(FlatLinkStyle())
                    }
                }
                .scrollTargetLayout()
                .padding(.bottom)
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}

#Preview {
    DashboardMatchCarousel()
}
