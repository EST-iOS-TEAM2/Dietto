//
//  ArticleView.swift
//  Dietto
//
//  Created by 안세훈 on 5/26/25.
//

import SwiftUI

struct ArticleView: View {
    let articles = [
        "https://www.youtube.com/watch?v=3p8EBPVZ2Iw",
        "https://www.news1.kr/articles/?5301234",
        "https://www.youtube.com/watch?v=F2ojC6TNwws",
        "https://www.youtube.com/watch?v=bz6GTYaIQXU"
    ]
    @StateObject var viewModel = ArticleViewModel()
    var body: some View {
        VStack{
            HStack {
                //MARK: - 로고
                Text("Dietto")
                    .font(.NerkoOne40)
                    .foregroundStyle(.text)
                Spacer()
                
                NavigationLink(destination: InterestsView(viewModel: viewModel)) {
                    Text("edit")
                        .font(.pretendardMedium16)
                        .foregroundColor(.white)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .background(Color.appMain)
                        .clipShape(Capsule())
                }
            }
            .padding([.leading, .trailing], 16)
            
            List(articles, id: \.self) { item in
                LinkRow(previewURL: URL(string: item)!)
            }
            .listStyle(.plain)

        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationView {
        ArticleView()
    }
    
}



//
//
//
/*
 [
   {
     "title": "계룡시, 등굣길 금연 캠페인 성황리에 마무리",
     "link": "https://www.news1.kr/articles/?5301234"
   },
   {
     "title": "영도구보건소, 금연구역 인증 걷기 챌린지 운영",
     "link": "https://www.news2.kr/articles/?5301235"
   },
   {
     "title": "광주시의회, 세계 금연의 날 맞아 금연 결의 대회 개최",
     "link": "https://www.news3.kr/articles/?5301236"
   },
   {
     "title": "팔굽혀펴기로 치매 예방하기?...근육량 증가하면 당뇨·치매 위험 낮아져 [Health Recipe]",
     "link": "https://www.healthnews.kr/articles/?5301237"
   },
   {
     "title": "노년층 복병 ‘골근감소증’ “장내 미생물 먹었더니”…뼈밀도·근육량 증가↑",
     "link": "https://www.healthnews.kr/articles/?5301238"
   },
   {
     "title": "체중 재증가하는 여성은 근육량보다 지방량 증가가 원인",
     "link": "https://www.healthnews.kr/articles/?5301239"
   },
   {
     "title": "금연 무기력함 극복하는 꿀팁 3가지를 소개합니다! : 네이버 블로그",
     "link": "https://blog.naver.com/PostView.nhn?blogId=example1&logNo=222123456789"
   },
   {
     "title": "근육량 증가, 근성장을 극대화해줄 꿀팁! - 네이버 블로그",
     "link": "https://blog.naver.com/PostView.nhn?blogId=example2&logNo=222123456790"
   },
   {
     "title": "지속 가능한 근육량 증가 운동 프로그램 : 네이버 블로그",
     "link": "https://blog.naver.com/PostView.nhn?blogId=example3&logNo=222123456791"
   }
 ]


 */
