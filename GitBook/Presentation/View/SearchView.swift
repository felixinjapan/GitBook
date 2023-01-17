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
    
    @Binding var menuOpened: Bool
    @State var searchText: String = ""
    //    @StateObject var viewModel = DefaultOwnerDetailViewModel()
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    Text("repo1")
                    //                    ForEach(model.familyNames, id: \.self) { familyName in
                    //
                    //                    }
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
        .onSubmit(of: .search) {
            //            model.fetchFamilyNames()
            print("submit")
        }
        
    }
}
