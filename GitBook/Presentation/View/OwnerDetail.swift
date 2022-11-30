//
//  OwnerDetail.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/12.
//

import SwiftUI

struct OwnerDetail: View {
    @EnvironmentObject var appDIContainer:AppDIContainer
    @EnvironmentObject var gitBookState: GitBookState
    var owner: Owner
    @StateObject var viewModel = DefaultOwnerDetailViewModel()
    @State private var showNonForkedOnly = true
    
    var filteredRepoList: [Repo] {
        gitBookState.currentRepoList.filter { repo in
            (!showNonForkedOnly || !repo.fork)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    AvatarImageView(url: owner.unwrappedAvatarUrl)
                    Text(owner.unWrappedUsername)
                        .font(.title)
                }
                HStack {
                    Text(owner.unWrappedFullName)
                    Spacer()
                    Text("Followers: \(owner.followers)")
                    Text("Following: \(owner.following)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                Toggle(isOn: $showNonForkedOnly) {
                    Text("Sources Only")
                }
                if gitBookState.isRepoListLoaded {
                    RepositoryList(repoList: filteredRepoList)
                } else {
                    ProgressView("Fetching...")
                        .frame(width: 100, height: 100, alignment: .leading)
                        .font(.system(size: 20))
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.inject(with: appDIContainer, with: gitBookState)
            viewModel.getRepo(with: owner)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {viewModel.refresh(with: owner) }) {
            Image(systemName: "arrow.up.arrow.down.circle")
                .imageScale(.large)
                .frame(width: 44, height: 44, alignment: .trailing)
            Text("Refresh")
        }.alert("Too many calls! Try again", isPresented: $gitBookState.showTooManyCallAlert){
            Button("OK", role: .cancel) { }
        })
    }
}

#if DEBUG
struct OwnerDetail_Previews: PreviewProvider {
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
