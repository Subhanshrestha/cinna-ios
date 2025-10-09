//
//  PrivacySecurity.swift
//  Cinna
//
//  Created by Brighton Young on 10/4/25.
//

import SwiftUI

struct PrivacySecurity: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Privacy & Security")
                    .font(.largeTitle.bold())

                Text("Manage authentication, data controls, and notification permissions in this area.")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Privacy & Security")
        .navigationBarTitleDisplayMode(.inline)
    }
}
