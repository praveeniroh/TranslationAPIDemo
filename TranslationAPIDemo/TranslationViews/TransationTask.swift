//
//  TransationTask.swift
//  TranslationAPIDemo
//
//  Created by praveen-12298 on 07/09/24.
//

import SwiftUI
import Translation


///In this view, translationTask used without configuration.
///So, the task closure called only once when the view appearing
///Target language will be selected by system based on your location
struct TransationTaskView: View {
    @State private var text: String = "Pluto is a dwarf planet located in the Kuiper Belt, a region of the Solar System beyond the orbit of Neptune filled with small, icy bodies. Discovered in 1930 by American astronomer Clyde Tombaugh, Pluto was originally classified as the ninth planet from the Sun. However, in 2006, the International Astronomical Union (IAU) redefined the criteria for what constitutes a planet, leading to Pluto’s reclassification as a dwarf planet."
    @State private var translationResponse: TranslationSession.Response?
    @State private var translatedText: String?


    var body: some View {
        Text(text)
            .padding()
            .border(Color.mint)
        //MARK: This function called only once when view appearing
            .translationTask{session in
                do{
                    let response = try await session.translate(text)
                    translationResponse = response
                    translatedText = response.targetText
                }catch{
                    translatedText = error.localizedDescription
                }
            }

        if let translatedText {
            Text(translatedText)
                .padding()
                .border(Color.mint)
        }

        if let translationResponse {
            Text("Souce language:  : \(translationResponse.sourceLanguage.maximalIdentifier)")
                .padding()
                .border(Color.mint)
            Text("Target language:  : \(translationResponse.targetLanguage.maximalIdentifier)")
                .padding()
                .border(Color.mint)

        }

    }
}

#Preview {
    TransationTaskView()
}
