//
//  SearchManager.swift
//  EventfulApp
//
//  Created by Lilli Cain on 10/21/24.
//

import Foundation
import SwiftUI

struct SearchManager: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> some UIView {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let view = uiView as? UISearchBar {
            view.text = text
        }
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
}
