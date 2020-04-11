//
//  ContentView.swift
//  iPhoneBezel
//
//  Created by Katsu Matsuda on 2020/04/11.
//  Copyright © 2020 Katsu Matsuda. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        iPhoneBezel {
            Text("""
                 iPhoneBezel {
                     // Add your SwiftUI View here
                 }
                 """)
                .lineLimit(3)
                .font(.system(.body, design: .monospaced))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
