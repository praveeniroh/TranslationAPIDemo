//
//  BulkTranslationView.swift
//  TranslationAPIDemo
//
//  Created by praveen-12298 on 07/09/24.
//

import SwiftUI
import Translation

struct TranslationSource{
    static let sourceText = [
        "冥王星是一颗位于柯伊伯带的矮行星，柯伊伯带是太阳系海王星轨道之外的一个区域，充满了小型冰冷天体。冥王星于 1930 年由美国天文学家克莱德·汤博发现",
        "冥王星是一颗位于柯伊伯带的矮行星，柯伊伯带是太阳系海王星轨道之外的一个区域，充满了小型冰冷天体。冥王星于 1930 年由美国天文学家克莱德·汤博发现",
        "冥王星是一颗位于柯伊伯带的矮行星，柯伊伯带是太阳系海王星轨道之外的一个区域，充满了小型冰冷天体。冥王星于 1930 年由美国天文学家克莱德·汤博发现",
        "冥王星是一颗位于柯伊伯带的矮行星，柯伊伯带是太阳系海王星轨道之外的一个区域，充满了小型冰冷天体。冥王星于 1930 年由美国天文学家克莱德·汤博发现"
    ]

    static var request : [TranslationSession.Request] = {
        var request = [TranslationSession.Request]()
        for (index,str) in sourceText.enumerated(){
            request.append(.init(sourceText: str, clientIdentifier: "\(index)"))
        }
        return request
    }()
}

struct BulkTranslationView: View {


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

                    Text(responses?[safeIndex:index]?.targetText ?? "")
                        .frame(maxWidth: .infinity,maxHeight: .infinity)
                        .padding()
                        .border(Color.mint)
                }
            }
        }
        .padding(5)
        .translationTask(configuration, action: {session in
            do{
                let response = try await session.translations(from: request)
                self.responses = response
            }catch{

            }
        })
    }
}

#Preview {
    BulkTranslationView()
}

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
