//
//  RelaxViewFooterLayout.swift
//  Kansho
//
//  Created by Dason Tiovino on 26/10/24.
//
import SwiftUI

struct RelaxViewFooterLayout: View{
    var body: some View{
        Button{
            
        } label: {
            RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                .fill(.appPrimary)
                .overlay{
                    
                }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 100
        )
    }
}
