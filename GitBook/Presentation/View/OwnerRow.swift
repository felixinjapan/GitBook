//
//  OwnerRow.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2022/11/12.
//

import SwiftUI

struct OwnerRow: View {
    var owner: Owner

    var body: some View {
        HStack {
            AvatarImageView(url: owner.unwrappedAvatarUrl)
            Text(owner.unWrappedUsername)
            Spacer()
        }
    }
}

#if DEBUG
struct OwnerRow_Previews: PreviewProvider {
    static var previews: some View {
        let owner = OwnerMock()
        Group {
            OwnerRow(owner: owner)
        }
    }
}
#endif

