//
//  RepositoryList.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/16.
//

import SwiftUI

struct RepositoryList: View {
    var repoList: [Repo]
    @State private var selected:Repo?
    var body: some View {
        List(Array(repoList.enumerated()), id: \.offset) { index, repo in
            Button {
                selected = repo
            } label: {
                RepositoryRow(repo: repo)
            }
        }.sheet(item: $selected, content: { repo in
            if let url = repo.getRepoUrl {
                WebView(url: url)
            }
        })
    }
}

#if DEBUG
struct RepositoryList_Previews: PreviewProvider {
    static var previews: some View {
        let repo = RepoMock()
        RepositoryList(repoList: [repo])
    }
}
#endif
