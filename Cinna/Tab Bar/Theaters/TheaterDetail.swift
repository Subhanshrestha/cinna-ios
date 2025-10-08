import SwiftUI

struct TheaterDetail: View {
    let theater: Theater

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Header image
                Image(theater.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .padding(.horizontal)

                // Text info
                VStack(alignment: .leading, spacing: 8) {
                    Text(theater.name)
                        .font(.title2)
                        .bold()

                    HStack {
                        Text("⭐️ \(theater.rating)")
                        Text("(\(theater.reviews) reviews)")
                            .foregroundColor(.gray)
                    }
                    .font(.subheadline)

                    Text(theater.type)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Divider()

                    Text("📍 \(theater.address)")
                        .font(.subheadline)

                    Text(theater.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.top, 4)

                    Divider()
                        .padding(.vertical, 8)

                    // Placeholder for future expansion
                    VStack(alignment: .leading, spacing: 6) {
                        Text("🎟 Coming Soon")
                            .font(.headline)
                        Text("Live showtimes, seat selection, and calendar integration will be added here.")
                            .font(.callout)
                            .foregroundColor(.blue)
                            .italic()
                    }
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
    TheaterDetail(theater: sampleTheaters[0])
}

