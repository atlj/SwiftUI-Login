import SwiftUI

struct CustomButton: View {
	let title: String
	var showLoadingIndicator: Binding<Bool>
	let onPress: () -> Void

	init(title: String, showLoadingIndicator: Binding<Bool>, onPress: @escaping () -> Void) {
		self.title = title
		self.showLoadingIndicator = showLoadingIndicator
		self.onPress = onPress
	}

	init(title: String, onPress: @escaping () -> Void) {
		self.title = title
		self.showLoadingIndicator = Binding.constant(false)
		self.onPress = onPress
	}

	var body: some View {
		Button {
			let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
			onPress()
			impactGenerator.impactOccurred()
		} label: {
			if showLoadingIndicator.wrappedValue {
				ProgressView()
					.foregroundColor(Color.primary)
					.padding(.vertical)
					.colorInvert()
					.frame(maxWidth: .infinity)
					.background(Color.primary)
			} else {
				Text(title)
					.foregroundColor(.primary)
					.padding(.vertical)
					.colorInvert()
					.frame(maxWidth: .infinity)
					.background(Color.primary)
			}
		}
		.clipShape(RoundedRectangle(cornerRadius: 5.0))
		.disabled(showLoadingIndicator.wrappedValue)
	}
}

struct CustomButton_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			CustomButton(title: "Register") {
				print("Register")
			}
			CustomButton_Preview_Loading()
		}
	}
}

struct CustomButton_Preview_Loading: View {
	@State private var isLoading = false

	var body: some View {
		CustomButton(title: "Sign In", showLoadingIndicator: $isLoading) {
			isLoading.toggle()
		}
	}
}
