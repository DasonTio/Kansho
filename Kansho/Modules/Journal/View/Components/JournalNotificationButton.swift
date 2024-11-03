//
//  JournalNotificationButton.swift
//  Kansho
//
//  Created by Dason Tiovino on 03/11/24.
//
import SwiftUI

struct JournalNotificationButton: View{
    var image: String
    var function: () -> Void
    
    var body: some View{

            Button(action: function){
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                    .fill(.appSecondary)
                    .overlay {
                        HStack{
                            VStack(alignment: .leading){
                                Text("Relax Session")
                                    .font(.themeHeadline(weight: .heavy))
                                    .foregroundStyle(.appPrimary)
                                
                                Text("Let's calm down and unwind")
                                    .font(.themeBody())
                                    .foregroundStyle(.appPrimary)
                            }
                            
                            Spacer()
                            
                            Image(image)
                                .resizable()
                                .scaledToFit()
                                .animation(.easeInOut, value: image)
                        }
                        .padding(.horizontal,20)
                        .clipped()
                        .cornerRadius(30)
                    }
                    .frame(
                        height: 110
                    )
                    .padding(.horizontal, 15)
                    .padding(.top, 47)
            }
    }
}
