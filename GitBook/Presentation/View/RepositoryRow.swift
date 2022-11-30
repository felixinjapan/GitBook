//
//  RepositoryRow.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/12.
//

import SwiftUI

struct RepositoryRow: View {
    var repo: Repo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(repo.unwrappedName)
                .font(.title3)
            HStack {
                Text("Language: \(repo.unwrappedLang)")
                Divider()
                Text("Star: \(repo.stargazersCount)")
            }.frame(height: 20)
            .font(.subheadline)
            .foregroundColor(.secondary)
            HStack {
                Text(repo.unwrappedDesc).multilineTextAlignment(.leading)
            }
            .font(.caption)
            Divider()
        }
    }
}

#if DEBUG
struct RepositoryRow_Previews: PreviewProvider {
    static var previews: some View {
        let repo = RepoMock()
        RepositoryRow(repo: repo)
    }
}
#endif
