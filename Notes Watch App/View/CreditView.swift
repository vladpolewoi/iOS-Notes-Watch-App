//
//  CreditView.swift
//  Notes Watch App
//
//  Created by Quest76 on 27.12.2023.
//

import SwiftUI

struct CreditView: View {
  @State private var randomNumber: Int = .random(in: 1 ..< 4)
  
  private var randomImage: String {
    return "developer-no\(randomNumber)"
  }
  
  var body: some View {
    VStack(spacing: 3) {
      Image(randomImage)
        .resizable()
        .scaledToFit()
        .layoutPriority(1)
      
      HeaderView(title: "Credits")
      
      Text("Robert Petras")
        .foregroundStyle(.primary)
        .fontWeight(.bold)
      
      Text("Developer")
        .font(.footnote)
        .foregroundStyle(.secondary)
        .fontWeight(.light)
    }
  }
}

#Preview {
  CreditView()
}
