//
//  JournalInputComponent.swift
//  Kansho
//
//  Created by Dason Tiovino on 28/10/24.
//

import SwiftUI

struct JournalInputComponent: View {
    
    @State private var journalTitle: String = ""
    @State private var journalDescription: String = ""
    
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .fill(.appPrimary)
            .overlay {
                ZStack {
                    VStack(alignment: .leading){
                        TextField(text: $journalTitle, label: {
                            Text("Journal title today...")
                        })
                        .font(.themeTitle3())
                        
                        Divider()
                            .padding(.bottom, 5)
                        
                        TextField(text: $journalDescription, label: {
                            Text("Write your thoughts here...")
                        })
                        .font(.themeBody())
                        .frame(
                            maxHeight: .infinity,
                            alignment: Alignment(
                                horizontal: .leading,
                                vertical: .top
                            )
                        )
                        
                        
                        HStack{
                            Button(action: {}){
                                RoundedRectangle(cornerSize: CGSize(
                                    width: 15,
                                    height: 15
                                ))
                                .fill(.appSecondary)
                                .overlay{
                                    Image(systemName: "paperplane")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.appPrimary)                   .padding(15)
                                }
                            }.frame(
                                width: 50,
                                height: 50
                            )
                        }
                        .frame(
                            maxWidth: .infinity,
                            alignment: Alignment(
                                horizontal: .trailing,
                                vertical: .center
                            )
                        )
                    }
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: Alignment(
                        horizontal: .leading,
                        vertical: .top
                    )
                )
                .padding(24)
                .clipped()
                .cornerRadius(30)
            }
            .frame(
                maxHeight: .infinity
            )
            .padding(.horizontal, 15)
            .padding(.top, 10)
    }
}
