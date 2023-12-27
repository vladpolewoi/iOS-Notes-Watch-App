//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Quest76 on 11.12.2023.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("lineCount") var lineCount: Int = 1
  
  @State private var notes: [Note] = .init()
  @State private var text: String = ""

  func getDocumentDirectory() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path[0]
  }

  func save() {
    do {
      // 1. Convert the note array to data useing JSONEncoder
      let data = try JSONEncoder().encode(notes)

      // 2. Create a new URL to  save th file using the getDocumentDirectory
      let url = getDocumentDirectory().appendingPathComponent("notes")

      // 3. Write the data to the given URL
      try data.write(to: url)
    } catch {
      print("Saving data has failed")
    }
  }

  func load() {
    DispatchQueue.main.async {
      do {
        // 1. Get the notes URL path
        let url = getDocumentDirectory().appendingPathComponent("notes")
        // 2. Create new property for the data
        let data = try Data(contentsOf: url)
        // 3. Decode the data
        notes = try JSONDecoder().decode([Note].self, from: data)
      } catch {
        // Do nothing
      }
    }
  }
  
  func delete(offsets: IndexSet) {
    withAnimation {
      notes.remove(atOffsets: offsets)
      save()
    }
  }

  var body: some View {
    VStack {
      HStack(alignment: .center, spacing: 6) {
        TextField("Add New Note", text: $text)

        Button {
          // 1. Only run button's action when the text field is not empty
          guard text.isEmpty == false else { return }
          // 2. Create a new note itenm and initialize it with the text value
          let note = Note(id: UUID(), text: text)
          // 3. Add the new note item to the notes array (append)
          notes.append(note)
          // 4. Make the text field empty
          text = ""
          // 5. Save the notes (function)
          save()
        } label: {
          Image(systemName: "plus.circle")
            .font(.system(size: 42, weight: .semibold))
        }
        .fixedSize()
        .buttonStyle(.plain)
        .foregroundStyle(.accent)
      }

      Spacer()

      if notes.count >= 1 {
        List {
          ForEach(0..<notes.count, id: \.self) { i in
            
            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
              HStack {
                
                Capsule()
                  .frame(width: 4)
                  .foregroundStyle(.accent)
                Text(notes[i].text)
                  .lineLimit(lineCount)
                  .padding(.leading, 5)
              }
            }
          }
          .onDelete(perform: delete)
        }
      } else {
        Spacer()
        Image(systemName: "note.text")
          .resizable()
          .scaledToFit()
          .foregroundStyle(.gray)
          .opacity(0.25)
          .padding(25)
        Spacer()
      }
    }
    .navigationTitle("Notes")
    .onAppear {
      load()
    }
  }
}

#Preview {
  ContentView()
}
