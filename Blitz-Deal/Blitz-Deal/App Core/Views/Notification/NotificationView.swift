//
//  NotificationView.swift
//  Blitz-Deal
//
//  Created by Viktor Schäfer on 11.03.24.
//

import SwiftUI

struct NotificationView: View {

    let notificationType: NotificationType
    let notificationMessage: String
    
    var body: some View {
        HStack {
            Rectangle()
                .foregroundStyle(self.notificationType.color)
                .frame(width: 10)
            
            VStack {
                Text(self.notificationType.title)
                    .foregroundStyle(self.notificationType.color)
                    .fontDesign(.rounded)
                    .fontWeight(.light)
                    .font(.title)
                  
                Divider()
                    .background(.white)
                    .padding([.leading, .trailing], 25)
                
                Text(self.notificationMessage)
                    .padding(.vertical, 5)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
        }
        .background(.white)
        .frame(height: 150)
        .border(self.notificationType.color)
    }
}

#Preview {
    NotificationView(notificationType: .info,
                     notificationMessage: "My notification Message!")
}
