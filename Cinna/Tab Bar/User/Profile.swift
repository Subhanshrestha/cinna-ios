//
//  Profile.swift
//  Cinna
//
//  Created by Brighton Young on 10/4/25.
//

import SwiftUI

struct Profile: View {
    @EnvironmentObject private var userInfo: UserInfoData
    
    var body: some View {
        Form {
            Section("*Cinna* Profile Details") {
                    HStack{
                        Text("Name")
                            .bold()
                        SwiftUI.TextField("Your name", text: $userInfo.name)
                            .textContentType(.name)
                            .contentShape(Rectangle())
                    }
                    
                    
                    Toggle("Use Current Location", isOn: $userInfo.useCurrentLocationBool)
                        .bold()
                        .tint(.accentColor)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }//end body
}

#Preview {
    Profile()
        .environmentObject(UserInfoData())
}
