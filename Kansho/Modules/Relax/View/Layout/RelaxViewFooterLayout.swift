//
//  RelaxViewFooterLayout.swift
//  Kansho
//
//  Created by Dason Tiovino on 26/10/24.
//
import SwiftUI

struct RelaxViewFooterLayout: View{
    @EnvironmentObject var relaxViewModel: RelaxViewModel
    var body: some View{
        Button{
            relaxViewModel.isJournaling.toggle()
        } label: {
            RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                .fill(.appPrimary)
                .overlay{
                    Image("journal_image")
                }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 100
        )
    }
}
