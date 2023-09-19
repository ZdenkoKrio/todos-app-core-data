//
//  SettingsScene.swift
//  ToDo App
//
//  Created by Zdenko Čepan on 19.09.2023.
//

import SwiftUI

struct SettingsScene: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section(header: Text("Follow us on social media")) {
                      FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://swiftuimasterclass.com")
                      FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com")
                      FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link: "")
                    } //: SECTION 3
                      .padding(.vertical, 3)
                    
                    Section(header: Text("About the aplication")) {
                        Section(header: Text("About the application")) {
                          FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                          FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                          FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Zdenko")
                          FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Petras")
                          FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                        } //: SECTION 4
                          .padding(.vertical, 3)
                    }
                } // FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                Text("Copyright © All rights reserved.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(.secondary)
            } //VSTACK
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("ColorBackground"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                } // TOOLBAR ITEM
            } // TOOLBAR
        } // NAVIGATION
    }
}

struct SettingsScene_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScene()
    }
}