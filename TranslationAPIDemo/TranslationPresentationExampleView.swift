//
//  TranslationPresentationExampleView.swift
//  TranslationAPIDemo
//
//  Created by praveen-12298 on 07/09/24.
//

import SwiftUI
import Translation

struct TranslationPresentationExampleView: View {
    @State private var isPresented: Bool = false
    @State private var text: String = "Pluto is a dwarf planet located in the Kuiper Belt, a region of the Solar System beyond the orbit of Neptune filled with small, icy bodies. Discovered in 1930 by American astronomer Clyde Tombaugh, Pluto was originally classified as the ninth planet from the Sun. However, in 2006, the International Astronomical Union (IAU) redefined the criteria for what constitutes a planet, leading to Pluto’s reclassification as a dwarf planet."
    @State private var translatedString: String?


    var body: some View {
        Text(text)
            .padding()
            .border(Color.mint)
            .translationPresentation(isPresented: $isPresented, text: text){ traslatedString in
                //Closure getting called when `Replace with transition` button tapped in overlay view
                self.text = traslatedString
            }
        Button("Translate", action: {
            isPresented.toggle()
        })
    }
}

#Preview {
    TranslationPresentationExampleView()
}
