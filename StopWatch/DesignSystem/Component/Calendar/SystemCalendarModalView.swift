//
//  SystemCalendarModalView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/28/25.
//

import SwiftUI

struct SystemCalendarModalView: View {
    @Binding var date: Date
    @Binding var isPresented: Bool
    
    @State var hideTime: Bool = true
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Spacer()
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .padding(4)
                        .foregroundStyle(Color.getColor(.gray_text))
                }
            }
            
            DatePicker.init("", selection: $date, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .labelsHidden()
                .tint(Color.getColor(.gray_text))
        }
        .padding()
        .background(Color.getColor(.background_primary))
        .clipShape(.rect(cornerRadius: 16))
        .padding(.horizontal, 38)
    }
}

#Preview {
    SystemCalendarModalView(date: .constant(.now), isPresented: .constant(true))
}

