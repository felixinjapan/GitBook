//
//  SearchRepoView.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2023/01/13.
//

import SwiftUI

struct SearchRepoView: View {
    @EnvironmentObject var appDIContainer: AppDIContainer
    @EnvironmentObject var gitBookState: GitBookState
    
    @Binding var menuOpened: Bool
    @State var searchText: String = ""
    @State var currentPage:Int = 1
    @StateObject var viewModel = DefaultSearchRepoViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center) {
                if gitBookState.isSearchRepoListLoaded {
                    RepositoryList(repoList: gitBookState.searchRepoList)
                        .padding()
                    Button {
                        currentPage+=1
                        viewModel.getRepo(query: searchText, page: currentPage)
                    } label: {
                        Text("More...").foregroundColor(.blue)
                    }
                } else {
                    ProgressView("Waiting...")
                        .frame(width: 100, height: 100, alignment: .leading)
                        .font(.system(size: 20))
                }
            }
            .navigationBarTitle(Text("Search Repos"))
            .navigationBarItems(leading:
                                    Button(action: { self.menuOpened.toggle() }) {
                Image(systemName: "line.3.horizontal.circle")
                    .imageScale(.large)
                    .frame(width: 44, height: 44, alignment: .trailing)
            })
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: Text("type repo name...")
        )
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .onSubmit(of: .search) {
            gitBookState.searchRepoList.removeAll()
            gitBookState.isSearchRepoListLoaded = false
            viewModel.getRepo(query: searchText, page: currentPage)
        }
        .onAppear {
            viewModel.inject(with: appDIContainer, with: gitBookState)
        }
        .onChange(of: searchText) { text in
            gitBookState.searchRepoList.removeAll()
            gitBookState.isSearchRepoListLoaded = false
            viewModel.getRepo(query: text, page: currentPage)
        }
        .alert("Too many hits...", isPresented: $gitBookState.showTooManyCallAlert){
            Button("OK", role: .cancel) { }
        }
    }
}
