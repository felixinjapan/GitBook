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

    // VM
    @StateObject private var viewModel = DefaultHomeViewModel()
    @State private var presentAlert = false
    @State private var username: String = ""
    @State private var menuOpened = false

    var body: some View {
        ZStack {
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
                }
                                    ,trailing:
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
                })
                )
            }.onAppear {
                viewModel.inject(with: appDIContainer, with: gitBookState)
                viewModel.initData()
            }
            //        .edgesIgnoringSafeArea(.all)
            SideMenu(menuOpened: self.$menuOpened)
        }
    }

    func deleteRow(at offsets: IndexSet) {
        viewModel.deleteData(at: offsets)
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

