//
//  MatchDetailsView+ViewModel.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 07/04/24.
//

import Foundation

extension MatchDetailsView {
    class ViewModel: ObservableObject {
        @Published var match: Match
        
        init(match: Match) {
            self.match = match
        }
    }
}
