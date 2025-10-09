//
//  MovieTickets.swift
//  Cinna
//
//  Created by Brighton Young on 10/4/25.
//

import SwiftUI

struct MovieTickets: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Movie Tickets")
                    .font(.largeTitle.bold())

                Text("Purchase history, upcoming showings, and ticket management will live here.")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Movie Tickets")
        .navigationBarTitleDisplayMode(.inline)
    }
}
