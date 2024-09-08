//
//  BulkTranslationWithAsyncSeqView.swift
//  TranslationAPIDemo
//
//  Created by praveen-12298 on 07/09/24.
//

import SwiftUI
import Translation

struct BulkTranslationWithAsyncSeqView: View {

    @State private var request = TranslationSource.request
    @State private var configuration : TranslationSession.Configuration?
    @State private var responses:[TranslationSession.Response]?
    var body: some View {

        Button("Translate") {
            if configuration == nil{
                configuration = TranslationSession.Configuration()
                configuration?.target = Locale.Language(identifier: "en_US")
            }else{
                configuration?.invalidate()
            }
        }
        .padding()

        ScrollView{
            ForEach(0..<request.count){index in
                HStack {
                    Text(request[index].sourceText)
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .padding()
                        .border(Color.mint)

                    Text(responses?.first(where: {$0.clientIdentifier == request[index].clientIdentifier})?.targetText ?? "")
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .padding()
                        .border(Color.mint)
                }
            }
        }
        .padding(5)
        .translationTask(configuration, action: {session in
            do{
                for try await response in session.translate(batch: request){
                    if responses == nil{
                        responses = [response]
                        
                    }else{
                        self.responses?.append(response)
                    }
                }
//                let response = try await session.translations(from: request)
//                self.responses = response
            }catch{

            }
        })
    }

}

#Preview {
    BulkTranslationWithAsyncSeqView()
}
