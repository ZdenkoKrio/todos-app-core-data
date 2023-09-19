//
//  FormRowView.swift
//  ToDo App
//
//  Created by Zdenko Čepan on 19.09.2023.
//

import SwiftUI

struct FormRowStaticView: View {
    let icon: String
    let firstText: String
    let secondText: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(.gray)
                Image(systemName: icon)
                    .foregroundColor(.white)
            } // ZSTACK
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(firstText)
                .foregroundColor(.gray)
            Spacer()
            Text(secondText)
        } // HSTACK
    }
}

struct FormRowStaticView_Previews: PreviewProvider {
    static var previews: some View {
        FormRowStaticView(icon: "heart", firstText: "Aplication", secondText: "ToDo")
           
    }
}
