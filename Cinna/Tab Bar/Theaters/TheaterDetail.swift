import SwiftUI

struct TheaterDetail: View {
    let theater: Theater

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Placeholder header image
                Image(systemName: "film")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .foregroundColor(.gray)
                    .opacity(0.5)
                    .padding()

                VStack(alignment: .leading, spacing: 8) {
                    Text(theater.name)
                        .font(.title2)
                        .bold()

                    if let rating = theater.rating {
                        Text("⭐️ \(rating, specifier: "%.1f")")
                            .font(.subheadline)
                            .foregroundColor(.orange)
                    }

                    if let address = theater.address {
                        Text("📍 \(address)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Divider()
                        .padding(.vertical, 8)

                    Text("🎟 Coming Soon")
                        .font(.headline)
                    Text("Live showtimes, seat previews, and calendar integration will appear here.")
                        .font(.callout)
                        .foregroundColor(.blue)
                        .italic()
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Theater Info")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    TheaterDetail(theater: Theater(
        id: "test",
        name: "Regal New River Valley",
        rating: 4.4,
        address: "Christiansburg, VA",
        location: .init(latitude: 37.129, longitude: -80.403)
    ))
}

