//
//  JournalModelLocal.swift
//  Kansho
//
//  Created by Dason Tiovino on 29/10/24.
//

import SwiftData
import UIKit
import Foundation

@Model
class JournalModelLocal: Identifiable {
    var id: UUID
    var title: String
    var content: String
    var imageData: Data? = nil
    
    init(id: UUID = UUID(), title: String, content: String, image: UIImage? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.imageData = image?.jpegData(compressionQuality: 1.0)
    }
}

extension JournalModelLocal{
    func toJournal() -> JournalModel {
        .init(title: title, content: content, imageData: imageData)
    }
}
