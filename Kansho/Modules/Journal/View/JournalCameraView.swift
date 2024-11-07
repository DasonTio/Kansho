//
//  JournalCameraView.swift
//  Kansho
//
//  Created by Dason Tiovino on 05/11/24.
//

import SwiftUI

struct JournalCameraView: View {
    var body: some View {
        NavigationView{
            ImagePicker()
                .ignoresSafeArea()    
        }.navigationBarBackButtonHidden()
    }
}

