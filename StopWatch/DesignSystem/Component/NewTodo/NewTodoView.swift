//
//  NewTodoView.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import SwiftUI

struct NewTodoView: View {
    
    @Namespace var animation
    @FocusState var isTyping: Bool
    
    @State var text: String = ""
    @Binding var show: Bool
    
    @State var selectedCategory: Category?
    @State var selectedDate: Date? = .now
    @State var isPresentedCalendar: Bool = false
    
    let categoryList: [Category]
    var didTapAdd: (Todo) -> Void
    var didTapAddCategory: (()->Void)?
    
    var body: some View {
        VStack(spacing: .zero) {
            ZStack(alignment: show ? .topLeading : .center) {
                RoundedRectangle(cornerRadius: show ? 24 : 40)
                    .foregroundStyle(Color.getColor(.gray_text))
                
                VStack(alignment: .leading) {
                    if show {
                        editNewTodoView
                    } else {
                        addTodoView
                    }
                }
                .frame(maxWidth: .infinity, alignment: show ? .leading : .center)
            }
            
            if show {
                FixedSpacer(12)
                addButton
            }
        }
        .frame(height: show ? 280: 50)
        .padding(.horizontal, show ? 16: 16)
        .clipped()
        .overlay {
            if isPresentedCalendar {
                SystemCalendarModalView(
                    selectedDate: selectedDate ?? .now,
                    isPresented: $isPresentedCalendar
                ) {
                    selectedDate = $0
                }
                .offset(y: -100)
            }
        }
        .animation(.easeInOut, value: isPresentedCalendar)
        .animation(.spring, value: show)
    }
}

private extension NewTodoView {
    // MARK: - Add TodoView
    var addTodoView: some View {
        Text("New Todo")
            .setTypo(.label2)
            .foregroundStyle(Color.white)
            .matchedGeometryEffect(id: "text", in: animation)
            .onTapGesture {
                show = true
            }
    }
    
    
    // MARK: - Edit TodoView
    var editNewTodoView: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Spacer()
                Button {
                    withAnimation {
                        resetData()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.white)
                        .padding([.top, .trailing])
                }
            }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .focused($isTyping)
                    .foregroundStyle(Color.white)
                    .scrollContentBackground(.hidden)
                if !isTyping {
                    Text("\(Image(systemName: "pencil")) What to do?")
                        .foregroundStyle(Color.init(hex: "F4F4E4") ?? .white)
                        .padding(.top, 8)
                        .fixedSize(horizontal: true, vertical: false)
                        .matchedGeometryEffect(id: "text", in: animation)
                }
            }
            .setTypo(.label2)
            .padding([.bottom, .horizontal])
            
            Spacer()
            Divider()
                .hSpacing()
                .background(Color.white)
                .padding(.horizontal, 24)
                .foregroundStyle(Color.white)
            
            VStack(spacing: 12) {
                selectCategoryView
                selectedDateView
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
        }
    }
    
    var addButton: some View {
        Button {
            guard selectedCategory != nil else { return }
            let newTodo = Todo(date: selectedDate, content: text, category: selectedCategory)
            didTapAdd(newTodo)
            resetData()
        } label: {
            Text("Add")
                .hSpacing(alignment: .center)
                .padding()
                .background(Color.getColor(.gray_text))
                .opacity(selectedCategory != nil ? 1 : 0.7)
                .clipShape(.rect(cornerRadius: 24))
                .foregroundStyle(Color.getColor(.white))
                .animation(.spring, value: selectedCategory)
        }
    }
    
    // MARK: - Select Category
    var selectCategoryView: some View {
        HStack(spacing: .zero) {
            Menu {
                Button {
                    didTapAddCategory?()
                } label: {
                    Text("카테고리 추가")
                }
                
                ForEach(categoryList, id: \.id) { category in
                    Button {
                        selectedCategory = category
                    } label: {
                        Text(category.name)
                    }
                }
            } label: {
                Text(selectedCategory?.name ?? "+ Category")
                    .setTypo(.label2)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(selectedCategory != nil ? Color.getColor(.background_primary) : .clear)
                    .roundedBorder(selectedCategory != nil ? .clear : Color.getColor(.background_primary), radius: 14, linewidth: 1)
                    .foregroundStyle(selectedCategory != nil ? Color.getColor(.gray_text) : .white)
                    .overlay(alignment: .topTrailing) {
                        Text("*")
                            .foregroundStyle(Color.red)
                            .offset(x: 5,y: -6)
                    }
            }
            Spacer()
        }
        .foregroundStyle(Color.white)
    }
    
    
    // MARK: - Select Date
    @ViewBuilder var selectedDateView: some View {
        HStack(spacing: .zero) {
            Button {
                withAnimation {
                    if selectedDate == nil {
                        selectedDate = .now
                    }
                    
                    isPresentedCalendar = true
                }
            } label: {
                Text(selectedDate?.formattedString(by: .yyyyMMddEEEKorean) ?? "+ Date")
                    .setTypo(.label2)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 12)
                    .background(selectedDate != nil ? Color.getColor(.background_primary) : .clear)
                    .roundedBorder(selectedDate != nil ? .clear : Color.getColor(.background_primary), radius: 14, linewidth: 1)
                    .foregroundStyle(selectedDate != nil ? Color.getColor(.gray_text) : .white)
            }
            .onChange(of: selectedDate) { oldValue, newValue in
                isPresentedCalendar = false
            }
            
            if selectedDate != nil {
                FixedSpacer(8)
                Button {
                    withAnimation {
                        selectedDate = nil
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundStyle(Color.getColor(.fill_disable))
                }
            }
            
            Spacer()
        }
    }
}

// MARK: - Private Method
private extension NewTodoView {
    func resetData() {
        text = ""
        selectedDate = .now
        selectedCategory = .none
        show = false
    }
}

#Preview {
    NewTodoView(
        show: .constant(true),
        categoryList: [
            .englishMock,
            .exerciseMock,
            .programmingMock
        ],
        didTapAdd: { _ in
        })
}
