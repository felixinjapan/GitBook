//
//  SearchView.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2023/01/13.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var appDIContainer: AppDIContainer
    @EnvironmentObject var gitBookState: GitBookState
//    @StateObject var viewModel = DefaultOwnerDetailViewModel()
//    @State private var showNonForkedOnly = true

    var body: some View {
        Text("new text")
//        NavigationView {
//            VStack(alignment: .leading) {
//                    ProgressView("Fetching...")
//                        .frame(width: 100, height: 100, alignment: .leading)
//                        .font(.system(size: 20))
//            }
//        }
//        .padding()
    }
//        .onAppear {
//            viewModel.inject(with: appDIContainer, with: gitBookState)
//        }
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarItems(trailing: Button(action: {viewModel.refresh(with: owner) }) {
//            Image(systemName: "arrow.up.arrow.down.circle")
//                .imageScale(.large)
//                .frame(width: 44, height: 44, alignment: .trailing)
//            Text("Refresh")
//        }.alert("Too many calls! Try again", isPresented: $gitBookState.showTooManyCallAlert){
//            Button("OK", role: .cancel) { }
//        })

}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let repoMock =  RepositoryMock()
        Group {
            OwnerDetail(owner: OwnerMock())
                .environmentObject(DevUtil.instance.gitBookStateFullStub)
                .environmentObject(AppDIContainer(respositoryContainer:repoMock))

            OwnerDetail(owner: OwnerMock())
                .environmentObject(DevUtil.instance.gitBookStateFullStub)
                .environmentObject(AppDIContainer(respositoryContainer: repoMock))
                .preferredColorScheme(.dark)
        }
    }
}
#endif
