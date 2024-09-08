//
//  MultipleLanguageTranslation.swift
//  TranslationAPIDemo
//
//  Created by praveen-12298 on 08/09/24.
//

import SwiftUI
import Translation

struct MultipleLanguageTranslation: View {
    private var chineseReqesut : [TranslationSession.Request] = [.init(sourceText: "冥王星是一颗位于柯伊伯带的矮行星，柯伊伯带是太阳系海王星轨道之外的一个区域，充满了小型冰冷天体。冥王星于 1930 年由美国天文学家克莱德·汤博发现", clientIdentifier: "cn")]
    private var arabicRequest : [TranslationSession.Request] = [.init(sourceText: "بلوتو هو كوكب قزم يقع في حزام كويبر، وهي منطقة في النظام الشمسي تقع خارج مدار", clientIdentifier: "ar")]

    @State private var configuration : TranslationSession.Configuration? = TranslationSession.Configuration(target: Locale.Language(identifier: "en_US"))
    @State private var responses:[TranslationSession.Response] = []

    var body: some View {
        Button("Translate") {
            if configuration == nil{
                configuration = TranslationSession.Configuration()
                configuration?.target = Locale.Language(identifier: "en_US")
            }else{
                configuration?.target = Locale.Language(identifier: "en_US")
                configuration?.invalidate()
            }
        }
        .padding()
        VStack{
            HStack {
                Text(arabicRequest[0].sourceText)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .padding()
                    .border(Color.mint)

                Text(responses.first(where: {$0.clientIdentifier == "ar"})?.targetText ?? "")
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .padding()
                    .border(Color.mint)
            }

            HStack {
                Text(chineseReqesut[0].sourceText)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .padding()
                    .border(Color.mint)

                Text(responses.first(where: {$0.clientIdentifier == "cn"})?.targetText ?? "")
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .padding()
                    .border(Color.mint)
            }
        }
        .padding()
        .translationTask(configuration){session in
            /*
             //MARK: Not preferred way to translate multiple language since all requests are send as single batch
            var requests: [TranslationSession.Request] = []
            requests.append(contentsOf: arabicRequest)
            requests.append(contentsOf: chineseReqesut)
            do{
                for try await response in session.translate(batch: requests){
                    self.responses?.append(response)
                }
            }catch{
                //handle error
                fatalError()
            }
             */

            do{
                for try await response in session.translate(batch: arabicRequest){
                    self.responses.append(response)
                }
                for try await response in session.translate(batch: chineseReqesut){
                    self.responses.append(response)
                }
            }catch{
                //Handle error
                print("\(error.localizedDescription)")
            }

        }
    }
}

#Preview {
    MultipleLanguageTranslation()
}
