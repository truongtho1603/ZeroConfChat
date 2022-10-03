//
//  ContentView.swift
//  ZeroConfChat
//
//  Created by Do, Tho on 26/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State var username = ""
    @State var browsingButtonTitle = ""

    var body: some View {
        VStack {
            TextField("Name", text: $username)
            Button(browsingButtonTitle) {
                //
            }
        }

        List {
            Text("User 1")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
