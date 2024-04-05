//
//  Item.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 05/04/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
