//
//  DetailView.swift
//  Notes Watch App
//
//  Created by Quest76 on 27.12.2023.
//

import SwiftUI

struct DetailView: View {
  let note: Note
  let count: Int
  let index: Int
  
  @State private var isCreditsPresented: Bool = false
  @State private var isSettingsPresented: Bool = false
  
  var body: some View {
    VStack(alignment: .center, spacing: 3) {
      HeaderView()
      
      Spacer()
      
      ScrollView(.vertical) {
        Text(note.text)
          .font(.title3)
          .fontWeight(.semibold)
          .multilineTextAlignment(.center)
      }
      
      Spacer()
      
      HStack(alignment: .center) {
        Image(systemName: "gear")
          .imageScale(.large)
          .onTapGesture {
            isSettingsPresented.toggle()
          }
          .sheet(isPresented: $isSettingsPresented, content: {
            SettingsView()
          })
        
        Spacer()
        
        Text("\(count) / \(index + 1)")
        
        Spacer()
        
        Image(systemName: "info.circle")
          .imageScale(.large)
          .onTapGesture {
            isCreditsPresented.toggle()
          }
          .sheet(isPresented: $isCreditsPresented, content: {
            CreditView()
          })
      }
      .foregroundStyle(.secondary)
    }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var sampleData: Note = .init(id: UUID(), text: "HELLO")
  
  static var previews: some View {
    DetailView(note: sampleData, count: 5, index: 1)
  }
}
