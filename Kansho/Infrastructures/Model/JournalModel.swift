//
//  JournalModel.swift
//  Kansho
//
//  Created by Dason Tiovino on 28/10/24.
//

import Foundation
import UIKit

struct JournalModel: Identifiable, Codable, Hashable {
    var id: UUID = .init()
    var title: String
    var content: String
    private var imageData: Data? = nil
    
    var image: UIImage? {
        get {
            guard let imageData = imageData else { return nil }
            return UIImage(data: imageData)
        }
        set {
            imageData = newValue?.jpegData(compressionQuality: 1.0) // Convert UIImage to Data
        }
    }
    
    init(id:UUID = .init(), title: String, content: String, imageData: Data? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.imageData = imageData
    }
    
}

extension JournalModel{
    func toJournalLocal() -> JournalModelLocal {
        .init(id: id, title: title, content: content, image: image)
    }
}
