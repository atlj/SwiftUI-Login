import Foundation

struct Login: Codable {
	let kind, localId, email, displayName, idToken: String
	let registered: Bool
}

enum LoginLoadError: Error {
	case notPresent
}

extension Login {
	func saveToKeychain() -> Bool {
		let query: [String: Any] = [
			kSecClass as String: kSecClassInternetPassword,
			kSecAttrAccount as String: self.email,
			kSecAttrServer as String: "firebaseLogin",
			kSecValueData as String: self.idToken.data(using: String.Encoding.utf8)!,
		]

		SecItemDelete(query as CFDictionary)
		let status = SecItemAdd(query as CFDictionary, nil)
		return status == errSecSuccess
	}

	static func clearKeychain() {
		let query: [String: Any] = [
			kSecClass as String: kSecClassInternetPassword,
			kSecAttrServer as String: "firebaseLogin",
		]

		SecItemDelete(query as CFDictionary)
	}

	static func loadFromKeychain() -> Result<Login, LoginLoadError> {
		let getQuery: [String: Any] = [
			kSecClass as String: kSecClassInternetPassword,
			kSecAttrServer as String: "firebaseLogin",
			kSecReturnAttributes as String: true,
			kSecReturnData as String: true,
		]
		var item: CFTypeRef?
		SecItemCopyMatching(getQuery as CFDictionary, &item)

		if let existingItem = item as? [String: Any] {
			let email = existingItem[kSecAttrAccount as String] as! String
			let tokenData = existingItem[kSecValueData as String] as! Data
			let token = String(data: tokenData, encoding: String.Encoding.utf8)!
			return .success(
				Login(
					kind: "", localId: "", email: email, displayName: "",
					idToken: token, registered: true))
		} else {
			return .failure(.notPresent)
		}
	}
}
