//
//  HeaderView.swift
//  Notes Watch App
//
//  Created by Quest76 on 27.12.2023.
//

import SwiftUI

struct HeaderView: View {
  var title: String = ""
  
  var body: some View {
    VStack {
      // Title
      if title != "" {
        Text(title.uppercased())
          .font(.title3)
          .fontWeight(.bold)
          .foregroundStyle(.accent)
      }
      
      // Separator
      HStack {
        Capsule()
          .frame(height: 1)

        Image(systemName: "note.text")

        Capsule()
          .frame(height: 1)
      }
      .foregroundStyle(.accent)
    }
  }
}

#Preview {
  Group {
    HeaderView(title: "Credits")
    HeaderView()
  }
}
