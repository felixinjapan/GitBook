//
//  SideMenu.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2023/01/14.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    let text: String
    let icon: String
    let type: Constants.Page
}

struct MenuContent: View {
    @EnvironmentObject var gitBookState: GitBookState

    let items: [MenuItem] = [
        MenuItem(text: "Users", icon: "person.badge.plus", type: .UserList),
        MenuItem(text: "Search Repo", icon: "mail.and.text.magnifyingglass", type: .Search)
    ]
    var bgColor: Color = Color(.init(
        red: 52 / 255,
        green: 70 / 255,
        blue: 182 / 255,
        alpha: 1))

    var body: some View {
        ZStack(alignment: .top) {
            bgColor
            VStack(alignment: .leading, spacing: 10) {
                ForEach(items) { item in
                    HStack {
                        Image(systemName: item.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30, alignment: .leading)
                        Text(item.text)
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: 22))
                            .multilineTextAlignment(.leading)
                    }
                    .onTapGesture {
                        print("page type: \(item.type)")
                        self.gitBookState.pageType = item.type
                    }
                }
                .padding(.vertical, 14)
                .padding(.leading, 8)
            }
            .padding(.top, 60)
        }
    }
}

struct SideMenu: View {
    var width = UIScreen.main.bounds.size.width * 0.6
    @Binding var menuOpened: Bool

    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.5))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(.easeInOut.delay(0.2), value: self.menuOpened)
            .onTapGesture {
                self.menuOpened.toggle()
            }

            HStack(alignment: .top) {
                MenuContent()
                    .frame(width: width)
                    .offset(x: self.menuOpened ? 0 : -width)
                    .animation(.default, value: self.menuOpened)
                Spacer()
            }

        }.edgesIgnoringSafeArea(.all)
    }

}
