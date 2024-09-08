//
//  TransationTaskWithConfigView.swift
//  TranslationAPIDemo
//
//  Created by praveen-12298 on 07/09/24.
//

import SwiftUI
import Translation

struct TransationTaskWithConfigView: View {
    @State private var text: String = "Pluto is a dwarf planet located in the Kuiper Belt, a region of the Solar System beyond the orbit of Neptune filled with small, icy bodies."
    @State private var translationResponse: TranslationSession.Response?
    @State private var translatedText: String?
    @State private var configuration: TranslationSession.Configuration = TranslationSession.Configuration()

    let supportedLanguages : [Locale.Language] = [.init(identifier: "ar_AR"), .init(identifier: "in_ID"),.init(identifier: "zh_CN"),.init(identifier: "ko_KR")]

    var body: some View {
        Button("update target language \(configuration.target?.maximalIdentifier ?? "*")", action: {
            configuration.target = supportedLanguages.randomElement()
        })
        Text(text)
            .padding()
            .border(Color.mint)
        //MARK: This function called only whenever the config changes
            .translationTask(configuration){session in
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
    TransationTaskWithConfigView()
}
