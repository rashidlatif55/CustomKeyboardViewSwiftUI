//
//  CustomKeyboardView.swift
//  CustomKeyboardSwiftUI
//
//  Created by Rashid Latif on 29/07/2024.
//

import SwiftUI

struct CustomKeyboardView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    CustomKeyboardView()
}


extension TextField {
    @ViewBuilder
    func inputKeyboardView<Content:View>(@ViewBuilder content:@escaping () -> Content) -> some View {
        self
            .background {
                SetCustomKeyboardView(keyboardContent: content())
            }
    }
}

struct SetCustomKeyboardView<Content:View> : UIViewRepresentable {
    var keyboardContent:Content
    @State var hostingContainer : UIHostingController<Content>?
    
    func makeUIView(context: Context) -> some UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let containerView = uiView.superview?.superview {
                if let textField = containerView.findTextField {
                    //update content
                    if textField.inputView == nil {
                        hostingContainer = UIHostingController(rootView: keyboardContent)
                        hostingContainer?.view.frame = .init(origin: .zero, size: hostingContainer?.view.intrinsicContentSize ?? .zero)
                        textField.inputView = hostingContainer?.view
                    }else {
                        hostingContainer?.rootView = keyboardContent
                    }
                    
                }
            }
        }
    }
    
}

extension UIView {
    var allSubViews: [UIView] {
        return subviews.flatMap { view in
            [view] + view.subviews
        }
    }
    
    var findTextField: UITextField? {
        if let textField = allSubViews.first(where: { view in
            view is UITextField
        }) as? UITextField {
            return textField
        }
        return nil
    }
}
