//
//  SwiftDataManager.swift
//  Kansho
//
//  Created by Dason Tiovino on 31/10/24.
//

import SwiftData

struct SwiftDataManager{
    public static var shared = SwiftDataManager()
    var container: ModelContainer?
    var context: ModelContext?
    
    init() {
        do{
            container = try ModelContainer(
                for: JournalModelLocal.self,
                /// isStoredInMemoryOnly is for preview purpose
                /// on: not saved in internal data
                /// off: saved in internal data
                configurations: ModelConfiguration(isStoredInMemoryOnly: false)
            )
            
            if let container{
                context = ModelContext(container)
            }
        }catch{
            debugPrint("Error initializing SwiftDataManager", error)
        }
    }
}
