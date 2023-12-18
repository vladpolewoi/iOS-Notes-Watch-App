//
//  Note.swift
//  Notes Watch App
//
//  Created by Quest76 on 11.12.2023.
//

import Foundation

struct Note: Identifiable, Codable {
  let id: UUID
  let text: String
}
