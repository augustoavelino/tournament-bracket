//
//  BracketDetailsMatchRow.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 09/04/24.
//

import SwiftUI

struct BracketDetailsMatchRow: View {
    var homeTitle: String
    var homeColor: Color = .green
    var awayTitle: String
    var awayColor: Color = .blue
    
    var body: some View {
        HStack {
            Text(homeTitle)
                .frame(maxWidth: .infinity)
            Text("X")
            Text(awayTitle)
                .frame(maxWidth: .infinity)
        }
        .swipeActions(edge: .leading) {
            Button("Winner") {
                // TODO: Implement winner feature
                print("WINNER: Home")
            }
            .tint(homeColor)
        }
        .swipeActions(edge: .trailing) {
            Button("Winner") {
                // TODO: Implement winner feature
                print("WINNER: Away")
            }
            .tint(awayColor)
        }
    }
}

#Preview {
    List(0..<1) { item in
        BracketDetailsMatchRow(
            homeTitle: "Home team",
            awayTitle: "Away team"
        )
    }
}
