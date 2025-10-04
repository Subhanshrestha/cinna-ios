//
//  Profile.swift
//  Cinna
//
//  Created by Brighton Young on 10/4/25.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Profile")
                    .font(.largeTitle.bold())
                
                Text("Account details and personal information will appear here.")
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}
