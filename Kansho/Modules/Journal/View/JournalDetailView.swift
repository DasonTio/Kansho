//
//  JournalDetailView.swift
//  Kansho
//
//  Created by Dason Tiovino on 04/11/24.
//


import SwiftUI
import Combine

struct JournalDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var journalViewModel: JournalViewModel
    @EnvironmentObject var routingManager: RoutingManager
    @State private var model: JournalModel?
    
    var id: UUID
    
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .fill(.appPrimary)
            .overlay {
                ZStack {
                    VStack(alignment: .leading){
                        if let dataModel = model {
                            Button(action:{
                                routingManager.selectedJournal = model
                                routingManager.navigate(to: .journalCameraView)
                            }){
                                
                                if let uiImage = dataModel.image {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                        .foregroundColor(.appSecondary.opacity(0.5))
                                        .overlay{
                                            Image(uiImage: uiImage)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                        }
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        
                                }else{
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                        .foregroundColor(.appSecondary.opacity(0.5))
                                        .overlay{
                                            Image(systemName: "photo")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40, height: 40)
                                                .foregroundColor(.appSecondary.opacity(0.5))
                                        }
                                }
                                
                            }
                            .frame(maxWidth: .infinity, maxHeight: 300)
                            .background(Color.clear)
                            
                            Spacer()
                                .frame(height: 30)
                            
                            TextField(text: Binding(
                                get: {dataModel.title},
                                set: {model?.title = $0}
                            ), label: {
                                Text("Journal title today...")
                            })
                            .font(.themeTitle3())
                            
                            Divider()
                                .padding(.bottom, 5)
                            
                            
                            TextEditor(text: Binding(
                                get: {dataModel.content},
                                set: {model?.content = $0}
                            ))
                                .scrollContentBackground(.hidden)
                                .background(Color.clear)
                                .font(.themeBody())
                            
                            
                            HStack{
                                Button(action: {
                                    journalViewModel.updateJournal(dataModel)
                                    presentationMode.wrappedValue.dismiss()
                                }){
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
                        }else{
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
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
            .onAppear {
                model = journalViewModel.fetchById(id).first
            }
    }
}
