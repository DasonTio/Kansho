//
//  JournalDetailView.swift
//  Kansho
//
//  Created by Dason Tiovino on 04/11/24.
//


import SwiftUI

struct JournalDetailView: View {
    @EnvironmentObject var routingManager: RoutingManager
    @Binding var model: JournalModel
    @State var showImagePicker: Bool = false
    @State var pickedImage: UIImage? = nil
    
    var function: ()->Void
    
    var body: some View {
        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
            .fill(.appPrimary)
            .overlay {
                ZStack {
                    VStack(alignment: .leading){
                        Button(action:{
                            routingManager.navigate(to: .journalCameraView)
                        }){
                            
                            if let uiImage = model.image {
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
                        
                        TextField(text: $model.title, label: {
                            Text("Journal title today...")
                        })
                        .font(.themeTitle3())
                        
                        Divider()
                            .padding(.bottom, 5)
                        
                        
                        TextEditor(text: $model.content)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
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
