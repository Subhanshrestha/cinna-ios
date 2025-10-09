//
//  DetailSection.swift
//  Cinna
//
//  Created by Chao Chen on 10/9/25.
//

import SwiftUI

struct DetailSection: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color(.systemYellow).opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            Text(content)
                .font(.body)
                .foregroundStyle(Color(.label))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
    }
}
