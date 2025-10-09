//
//  TagBadge.swift
//  Cinna
//
//  Created by Chao Chen on 10/9/25.
//

import SwiftUI

struct TagBadge: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(Color(.tertiarySystemFill))
            .foregroundStyle(Color(.secondaryLabel))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
