//
//  EmptyStateView.swift
//  Journali
//
//  Created by joud on 30/05/1448 AH.
//

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            
            VStack {
                Image("Image 1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                
                Text("Begin Your Journal")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(Color(red: 0.69, green: 0.60, blue: 0.99))
                
                Text("Craft your personal diary, tap the plus icon to begin")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    EmptyStateView()
}
