import SwiftUI


struct WhatIFView: View {
    @Binding var totalGameTime: Int
    
    @State private var data1: [Topic] = [
        Topic(title: "23년 최저임금으로", timeSpent: 60, done: "원 벌기", count: 9620),
        Topic(title: "알고리즘", timeSpent: 45, done: "개 풀기", count: 1),
        Topic(title: "걸어서 칼로리", timeSpent: 60, done: "소모", count: 256),
        Topic(title: "연애를 할 수 있는 횟수", timeSpent: 240, done: "회", count: 0),
        // 다른 주제 추가
    ]
    @State private var data2: [Topic] = [
        Topic(title: "코인 노래방", timeSpent: 4, done: "곡 부르기", count: 1),
        Topic(title: "아카데미 세션", timeSpent: 240, done: "번 가기", count: 1),
        Topic(title: "수면", timeSpent: 480, done: "일 꿀잠", count: 1),
        Topic(title: "연애를 할 수 있는 횟수", timeSpent: 240, done: "회", count: 0),
        // 다른 주제 추가
    ]
    @State private var data3: [Topic] = [
        Topic(title: "코드", timeSpent: 3, done: "줄 작성", count: 1),
        Topic(title: "학식", timeSpent: 45, done: "번 먹기", count: 1),
        Topic(title: "책 읽기", timeSpent: 240, done: "권", count: 1),
        Topic(title: "연애를 할 수 있는 횟수", timeSpent: 240, done: "회", count: 0),
        // 다른 주제 추가
    ]
    @State private var selectedData: [Topic] = []
    
    let columns = [
        GridItem(.adaptive(minimum: 1000))
    ]
    
    init(totalGameTime: Binding<Int>) {
        self._totalGameTime = totalGameTime
        self._selectedData = State(initialValue: data1)
    }
    
    var body: some View {
        ZStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    Spacer()
                    Section {
                        HStack {
                            Text("롤체를 안 했더라면...")
                                .font(.title3)
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(.gray)
                         
                    }
                    ForEach(selectedData) { topic in
                        VStack {
                            Text(topic.title)
                                .foregroundStyle(.white)
                                .font(.body)
                                .padding(.bottom, 10)
                            HStack(spacing: 0) {
                                Text("\(totalGameTime / topic.timeSpent * topic.count)")
                                    .foregroundStyle(.white)
                                    .font(.title2)
                                    .bold()
                                Text(topic.done)
                                    .foregroundStyle(.white)
                                    .font(.title2)
                            }
                            
                        }
                        .frame(width: 300, height: 120)
                        .background(.gray)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.2), radius: 4)
                    }
                    Button(action: {
                        switch selectedData {
                        case data1:
                            selectedData = data2
                        case data2:
                            selectedData = data3
                        default:
                            selectedData = data1
                        }
                    }, label: {
                        VStack {
                            Text("새로운 컨텐츠 보기")
                                .font(.title2)
                                
                        }
                        .frame(width: 300, height: 120)
                        .background(.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.2), radius: 4)
                    })
                }
                .padding(.horizontal)
            }
        }
        .background(.black)
        
    }
}

#Preview {
    WhatIFView(totalGameTime: .constant(1000))
}
