//
//  JournalCameraView.swift
//  Kansho
//
//  Created by Dason Tiovino on 05/11/24.
//

import SwiftUI

struct JournalCameraView: View {
    @Binding var pickedImage: UIImage?
    var body: some View {
        NavigationView{
            ImagePicker(image: $pickedImage)
                .ignoresSafeArea()    
        }.navigationBarBackButtonHidden()
    }
}

