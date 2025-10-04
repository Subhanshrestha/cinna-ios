//
//  User.swift
//  Cinna
//
//  Created by Brighton Young on 9/26/25.
//

import SwiftUI

struct User: View {
    @State private var showNotifications = false
    
    //Custom notifications - temporary
    private let notifications: [UserNotification] = [
        .init(id: UUID(), title: "Ticket Reminder", message: "Don't forget your showing tonight at 7:30 PM."),
        .init(id: UUID(), title: "New Recommendation", message: "We've added sci-fi thrillers to your weekly picks."),
        .init(id: UUID(), title: "Seat Upgrade", message: "Premium seating now available for your favorite theater." )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Account Preferences")
                        .font(.title2.bold())
                    
                    Text("Your personalized settings and history will appear here.")
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if showNotifications {
                    NotificationDropdown(notifications: notifications)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .padding(.trailing)
                        .padding(.top, 8)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            showNotifications.toggle()
                        }
                    } label: {
                        Image(systemName: showNotifications ? "bell.fill" : "bell")
                            .font(.title3.weight(.semibold))
                            .accessibilityLabel("Notifications")
                    }
                }
            }
        }
    }
}

private struct NotificationDropdown: View {
    let notifications: [UserNotification]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Notifications")
                .font(.headline)
            
            if notifications.isEmpty {
                Text("You're all caught up!")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(notifications) { notification in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(notification.title)
                            .font(.subheadline.weight(.semibold))
                        Text(notification.message)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
                    if notification.id != notifications.last?.id {
                        Divider()
                    }
                }
            }
        }
        .padding(16)
        .frame(maxWidth: 280, alignment: .leading)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 8)
    }
}

private struct UserNotification: Identifiable, Equatable {
    let id: UUID
    let title: String
    let message: String
}

#Preview {
    User()
}
