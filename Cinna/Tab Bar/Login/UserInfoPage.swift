//
//  UserInfoPage.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//

import SwiftUI

// Keep the simple Genre type
enum Genre: String, CaseIterable, Identifiable {
    case action, comedy, drama, thriller, horror, scifi, fantasy, romance, animation, documentary
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
    var symbol: String {
        switch self {
        case .action: return "bolt.fill"
        case .comedy: return "face.smiling"
        case .drama: return "theatermasks.fill"
        case .thriller: return "eye"
        case .horror: return "spider"
        case .scifi: return "sparkles"
        case .fantasy: return "wand.and.stars"
        case .romance: return "heart.fill"
        case .animation: return "film.stack"
        case .documentary: return "doc.text.fill"
        }
    }
}

struct UserInfoView: View {
    @Binding var name: String
    @Binding var selectedGenres: Set<Genre>
    @Binding var useCurrentLocation: Bool

    var next: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Title
            Text("Cinna")
                .font(.largeTitle).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 24)

            // Content
            List {
                Section("Your Name") {
                    // Qualify TextField to avoid conflict with any custom TextField in your project
                    SwiftUI.TextField("e.g., Alex", text: $name)
                        .textContentType(.name)
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
                        }
                        .buttonStyle(.plain)
                    }
                }

                Section("Location") {
                    Toggle("Use Current Location", isOn: $useCurrentLocation)
                        .tint(.accentColor)
                }
            }
            .listStyle(.insetGrouped)

            // Continue button (always enabled—no validation)
            Button {
                // lightweight persistence if you want it
                UserDefaults.standard.set(name, forKey: "onboard_name")
                UserDefaults.standard.set(Array(selectedGenres.map { $0.rawValue }), forKey: "onboard_genres")
                UserDefaults.standard.set(useCurrentLocation, forKey: "onboard_location_current")
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

    //toggle the genres
    private func toggle(_ genre: Genre) {
        if selectedGenres.contains(genre) {
            selectedGenres.remove(genre)
        } else {
            selectedGenres.insert(genre)
        }
    }
}
