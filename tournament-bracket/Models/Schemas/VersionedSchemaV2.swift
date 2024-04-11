//
//  VersionedSchemaV2.swift
//  tournament-bracket
//
//  Created by Augusto Avelino on 11/04/24.
//

import Foundation
import SwiftData

enum VersionedSchemaV2: VersionedSchema {
    static var models: [any PersistentModel.Type] {
        [tournament_bracket.Bracket.self]
    }
    
    static var versionIdentifier: Schema.Version = .init(1, 1, 0)
}
