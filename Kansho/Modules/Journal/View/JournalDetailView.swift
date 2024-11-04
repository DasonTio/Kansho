//
//  JournalDetailView.swift
//  Kansho
//
//  Created by Dason Tiovino on 04/11/24.
//


import SwiftUI

struct JournalDetailView: View {
    @Binding var model: JournalModel
    
    var function: ()->Void
    
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .fill(.appPrimary)
            .overlay {
                ZStack {
                    VStack(alignment: .leading){
                        TextField(text: $model.title, label: {
                            Text("Journal title today...")
                        })
                        .font(.themeTitle3())
                        
                        Divider()
                            .padding(.bottom, 5)
                        
                        
                        TextEditor(text: $model.content)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear) // Makes the background clear
                            .font(.themeBody())
                        
                        
                        HStack{
                            Button(action: function){
                                RoundedRectangle(cornerSize: CGSize(
                                    width: 15,
                                    height: 15
                                ))
                                .fill(.appSecondary)
                                .overlay{
                                    Image(systemName: "paperplane")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.appPrimary)
                                        .padding(15)
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
