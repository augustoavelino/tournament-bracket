//
//  TBNumberFormatter.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 07/04/24.
//

import Foundation

class TBNumberFormatter: NumberFormatter {
    func string(from number: NSNumber, altOrdinal: Bool = false) -> String? {
        if numberStyle == .ordinal && altOrdinal && locale.identifier == "pt_BR" {
            return altOrdinalPTBR(from: number)
        }
        return super.string(from: number)
    }
    
    private func altOrdinalPTBR(from number: NSNumber) -> String? {
        return "\(number)ª"
    }
}
