//
//  SystemCalendarModalView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/28/25.
//

import SwiftUI

struct SystemCalendarModalView: View {
    @State var selectedDate: Date
    @Binding var isPresented: Bool
    
    var action: ((Date)->Void)?
    
    init(
        selectedDate: Date = .now,
        isPresented: Binding<Bool>,
        action: ((Date) -> Void)? = nil
    ) {
        self.selectedDate = selectedDate
        self._isPresented = isPresented
        self.action = action
    }
    
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
            
            DatePicker.init("",
                selection: Binding(
                    get: { selectedDate },
                    set: { didTappedDay(with: $0) }
                ),
                displayedComponents: [.date]
            )
                .datePickerStyle(.graphical)
                .labelsHidden()
                .tint(Color.getColor(.gray_text))
        }
        .padding()
        .background(Color.getColor(.background_primary))
        .clipShape(.rect(cornerRadius: 16))
        .padding(.horizontal, 38)
    }
    
    func didTappedDay(with date: Date) {
        selectedDate = date
        action?(selectedDate)
        isPresented = false
    }
}

#Preview {
    SystemCalendarModalView(isPresented: .constant(true))
}

