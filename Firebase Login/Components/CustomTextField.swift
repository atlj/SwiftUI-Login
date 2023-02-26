//
//  CustomTextField.swift
//  Firebase Login
//
//  Created by Burak Güner on 26.02.2023.
//

import SwiftUI

struct CustomTextField: View {
	var title: String
	@Binding var text: String

	var body: some View {
		TextField(title, text: $text)
			.padding(.all)
			.overlay(
				RoundedRectangle(cornerRadius: 5.0).stroke(
					Color.primary.opacity(0.5), lineWidth: 0.6))
	}
}

struct CustomTextField_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			EmptyTest()
			FullTest()
		}
	}
}

struct EmptyTest: View {
	@State private var text = ""
	var body: some View {
		CustomSecureField(title: "Test", text: $text)
	}
}

struct FullTest: View {
	@State private var text = "Look it's filled now"
	var body: some View {
		CustomSecureField(title: "Test", text: $text)
	}
}
