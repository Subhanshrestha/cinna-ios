//
//  RatingBadge.swift
//  Cinna
//
//  Created by Chao Chen on 10/9/25.
//

import SwiftUI

struct RatingBadge: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color(.systemYellow).opacity(0.2))
            .foregroundStyle(Color(.systemOrange))
            .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
    }
}
