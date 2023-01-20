//
//  HomeView.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/08.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var appDIContainer:AppDIContainer
    @EnvironmentObject var gitBookState: GitBookState

    @State private var menuOpened = false

    var body: some View {
        ZStack {
            switch gitBookState.pageType {
            case .UserList:
                UserListView(menuOpened: self.$menuOpened)
            case .Search:
                SearchRepoView(menuOpened: self.$menuOpened)
            }
            SideMenu(menuOpened: self.$menuOpened)
        }
    }
}

#if DEBUG
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
                .environmentObject(DevUtil.instance.gitBookStateFullStub)
                .environmentObject(AppDIContainer())
                .navigationBarHidden(true)
            Home()
                .environmentObject(DevUtil.instance.gitBookStateFullStub)
                .environmentObject(AppDIContainer())
                .navigationBarHidden(true)
                .preferredColorScheme(.dark)
        }
    }
}
#endif

