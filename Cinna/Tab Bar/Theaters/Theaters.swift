import SwiftUI

struct Theater: Identifiable {
    let id = UUID()
    let name: String
    let rating: String
    let reviews: String
    let type: String
    let address: String
    let description: String
    let imageName: String
}

let sampleTheaters: [Theater] = [
    Theater(name: "B&B Theatres Blacksburg 11 with B-Roll Bowling",
            rating: "4.4", reviews: "2.4K", type: "Movie theater",
            address: "1614 S Main St, Christiansburg, VA",
            description: "Comfortable seating, adequate concessions, clean theatre, and bathrooms.",
            imageName: "theater1"),
    Theater(name: "Regal New River Valley",
            rating: "4.4", reviews: "1.5K", type: "Movie theater",
            address: "Christiansburg, VA",
            description: "Spacious seating with fully reclining chairs",
            imageName: "theater2"),
    Theater(name: "Lyric Theatre",
            rating: "4.8", reviews: "391", type: "Performing arts theater",
            address: "135 College Ave, Blacksburg, VA",
            description: "Shows excellent films, has concerts and has a bar!",
            imageName: "theater3"),
    Theater(name: "Scarette’s Radford Cinema",
            rating: "4.5", reviews: "324", type: "Movie theater",
            address: "Fairlawn, VA",
            description: "The theater is small, intimate, and has great sound.",
            imageName: "theater4")
]

struct Theaters: View {
    var body: some View {
        VStack(spacing: 0) {
            // Static header
            VStack(alignment: .leading, spacing: 6) {
                Text("Theaters")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    .padding(.top, 12)

                HStack {
                    Image(systemName: "location.fill")
                        .foregroundColor(.blue)
                    Text("McBryde Hall, Blacksburg")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                }
                .padding(.horizontal)

                Text("Selected Movie: The Lion King")
                    .font(.subheadline)
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .background(Color.white)
            .shadow(radius: 1)

            // Scrollable list stays below header
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(sampleTheaters) { theater in
                        HStack(alignment: .top, spacing: 12) {
                            Image(theater.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(theater.name)
                                    .font(.headline)
                                HStack(spacing: 4) {
                                    Text("⭐️ \(theater.rating)")
                                    Text("(\(theater.reviews))")
                                        .foregroundColor(.gray)
                                }
                                .font(.subheadline)
                                Text(theater.type)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(theater.address)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Text("“\(theater.description)”")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 1)
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 10)
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    Theaters()
}

