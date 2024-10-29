//
//  JournalModel.swift
//  Kansho
//
//  Created by Dason Tiovino on 28/10/24.
//

import Foundation

struct JournalModel: Identifiable, Codable {
    var id: UUID = .init()
    var title: String
    var content: String
}

extension JournalModel{
    func toJournalDTO()->JournalModelDTO{
        .init(id: id, title: title, content: content)
    }
}
