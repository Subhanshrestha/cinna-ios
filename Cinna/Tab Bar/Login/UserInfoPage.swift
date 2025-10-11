//
//  UserInfoPage.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//

import SwiftUI

struct UserInfoView: View {
    
    @EnvironmentObject private var userInfo: UserInfoData
    @EnvironmentObject private var moviePreferences: MoviePreferencesData
    
    var next: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text("*Cinna*")
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 24)
            
            List {
                Section("Your Name") {
                    SwiftUI.TextField("e.g., Success Qu'avon", text: $name)
                        .textContentType(.name)
                }
                
                Section("Location Preference") {
                    Toggle("Use Current Location", isOn: $useCurrentLocation)
                        .tint(.accentColor)
                }
                
                Section("What do you like to watch?") {
                    ForEach(Genre.allCases) { genre in
                        Button {
                            moviePreferences.toggleGenre(genre)
                        } label: {
                            HStack {
                                Image(systemName: genre.symbol)
                                    .frame(width: 24)
                                Text(genre.title)
                                Spacer()
                                if moviePreferences.selectedGenres.contains(genre) {
                                    Image(systemName: "checkmark")
                                        .font(.body.weight(.semibold))
                                }
                            }
                            .contentShape(Rectangle()) //CRITICAL for making the button be tappable edge to edge
                        }
                        .buttonStyle(.plain)
                        
                    }
                }
                
            }
            .listStyle(.insetGrouped)
            
            Button {
                next()
            } label: {
                Text("Continue")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .padding(.horizontal)
                    .padding(.vertical, 12)
            }
        }
        .background(Color(.systemBackground))
    }
}

#Preview {
    UserInfoView() { }
        .environmentObject(userInfo)
        .environmentObject(moviePreferences)
    
}
