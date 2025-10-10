//
//  UserInfoPage.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//

import SwiftUI

struct UserInfoView: View {
    @Binding var name: String
    @Binding var useCurrentLocation: Bool
    @Binding var selectedGenres: Set<Genre>
    
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
                            toggle(genre)
                        } label: {
                            HStack {
                                Image(systemName: genre.symbol)
                                    .frame(width: 24)
                                Text(genre.title)
                                Spacer()
                                if selectedGenres.contains(genre) {
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
    
    private func toggle(_ genre: Genre) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
    }
}

#Preview {
    @Previewable @State var name = "Daquon"
    @Previewable @State var useCurrentLocation = true
    @Previewable @State var selectedGenres: Set<Genre> = [.action, .comedy]
    UserInfoView(
        name: $name,
        useCurrentLocation: $useCurrentLocation,
        selectedGenres: $selectedGenres
    ) { }
}
