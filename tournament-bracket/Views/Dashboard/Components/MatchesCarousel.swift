//
//  MatchesCarousel.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 06/04/24.
//

import SwiftUI

struct MatchesCarousel: View {
    var matches: [Match] = []
    var didSelectMatch: ((Match) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            Text("Up next")
                .font(.headline)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
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
                            MatchCard(homeCompetitor: match.homeCompetitor?.name ?? "Home", awayCompetitor: match.awayCompetitor?.name ?? "Away")
                                .onTapGesture {
                                    didSelectMatch?(match)
                                }
                                .containerRelativeFrame(.horizontal)
                        }
                    }
                    .scrollTargetLayout()
                    .padding(.bottom)
                }
                .scrollTargetBehavior(.viewAligned)
            }
        }
    }
}

#Preview {
    MatchesCarousel()
}
