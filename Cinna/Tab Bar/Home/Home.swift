import SwiftUI

struct Home: View {
    @StateObject private var vm = HomeViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView()
                } else if let e = vm.error {
                    Text(e)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("Recommended for you")
                                .font(.largeTitle.bold())
                                .foregroundStyle(Color(.label))
                            VStack(spacing: 16) {
                                ForEach(vm.recommendations) { recommendation in
                                    NavigationLink(value: recommendation) {
                                        RecommendationCard(recommendation: recommendation)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 32)
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationDestination(for: MovieRecommendation.self) { recommendation in
                MovieDetailView(recommendation: recommendation)
            }
            .navigationTitle("Home")
        }
        .task { await vm.load() }
    }
}

#Preview {
    Home()
}
