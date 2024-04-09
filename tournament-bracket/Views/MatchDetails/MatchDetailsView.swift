//
//  MatchDetailsView.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 07/04/24.
//

import SwiftUI

struct MatchDetailsView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            DashboardMatchCard(homeCompetitor: viewModel.match.homeCompetitor?.name ?? "Home", awayCompetitor: viewModel.match.awayCompetitor?.name ?? "Away", date: viewModel.match.date)
            Spacer()
        }
    }
    
    init(match: Match) {
        viewModel = ViewModel(match: match)
    }
}

#Preview {
    let homeCompetitor = Competitor(id: UUID(), name: "Home")
    let awayCompetitor = Competitor(id: UUID(), name: "Away")
    let match = Match(id: UUID(), homeCompetitor: homeCompetitor, awayCompetitor: awayCompetitor, date: Date())
    return MatchDetailsView(match: match)
}
