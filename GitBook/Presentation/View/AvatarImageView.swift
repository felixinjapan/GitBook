//
//  AvatarImageView.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/17.
//

import SwiftUI

struct AvatarImageView: View {
    var url:URL?
    
    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
            } else if phase.error != nil {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            } else {
                ProgressView()
            }
        }
        .frame(width: 50, height: 50)
    }
}

#if DEBUG
struct AvatarImageView_Previews: PreviewProvider {
    static var previews: some View {
        let url = OwnerMock().unwrappedAvatarUrl
        AvatarImageView(url: url)
    }
}
#endif
