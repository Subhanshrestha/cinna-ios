//
//  TextField.swift
//  Cinna
//
//  Created by Brighton Young on 10/9/25.
//
import SwiftUI

struct TextField: View {

    let title: String

    var body: some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .strokeBorder(.gray.opacity(0.3))
            .frame(height: 52)
            .overlay(alignment: .leading) {
                Text(title)
                    .foregroundStyle(.gray.opacity(0.7))
                    .padding(.horizontal)
            }
    }
}
