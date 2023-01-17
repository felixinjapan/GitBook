//
//  UserListView.swift
//  GitBook
//
//  Created by Chon, Felix | Felix | MESD on 2023/01/17.
//
import SwiftUI

struct UserListView: View {

    @EnvironmentObject var appDIContainer:AppDIContainer
    @EnvironmentObject var gitBookState: GitBookState

    // VM
    @StateObject private var viewModel = DefaultUserListViewModel()
    @State private var presentAlert = false
    @State private var username: String = ""
    @Binding var menuOpened: Bool

    var body: some View {
        NavigationView {
            List {
                ForEach(gitBookState.listOfOwners) { owner in
                    NavigationLink {
                        OwnerDetail(owner: owner)
                    } label: {
                        OwnerRow(owner: owner)
                    }
                }.onDelete(perform: deleteRow)
            }
            .navigationTitle("Users")
            .navigationBarItems(leading:
                Button(action: { self.menuOpened.toggle() }) {
                Image(systemName: "line.3.horizontal.circle")
                    .imageScale(.large)
                    .frame(width: 44, height: 44, alignment: .trailing)
            }, trailing:
                Button(action: { presentAlert.toggle() }) {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .frame(width: 44, height: 44, alignment: .trailing)
            }.alert("Add Owner", isPresented: $presentAlert, actions: {
                TextField("Username", text: $username)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                Button("OK", action: {viewModel.getOwner(with: username)})
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text("Please enter github username.")
            }))
        }.onAppear {
            viewModel.inject(with: appDIContainer, with: gitBookState)
            viewModel.initData()
        }
    }

    func deleteRow(at offsets: IndexSet) {
        viewModel.deleteData(at: offsets)
    }
}
