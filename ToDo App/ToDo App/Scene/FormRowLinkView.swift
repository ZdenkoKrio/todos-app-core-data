//
//  FormRowLinkView.swift
//  ToDo App
//
//  Created by Zdenko Čepan on 19.09.2023.
//

import SwiftUI

struct FormRowLinkView: View {
    let icon: String
    let color: Color
    let text: String
    let link: String
    
    var body: some View {
        HStack {
          ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
              .fill(color)
            Image(systemName: icon)
              .imageScale(.large)
              .foregroundColor(Color.white)
          } // ZSTACK
          .frame(width: 36, height: 36, alignment: .center)
          
          Text(text).foregroundColor(Color.gray)
          
          Spacer()
          
          Button(action: {
            guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
              return
            }
            UIApplication.shared.open(url as URL)
          }) {
            Image(systemName: "chevron.right")
              .font(.system(size: 14, weight: .semibold, design: .rounded))
          } // BUTTON
          .accentColor(Color(.systemGray2))
        } // HSTACK
    }
}

struct FormRowLinkView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://wikipedia.com")
    }
}
