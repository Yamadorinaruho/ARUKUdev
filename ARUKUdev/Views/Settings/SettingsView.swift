import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: Text("アカウント設定")) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                            VStack(alignment: .leading) {
                                Text("ユーザー名")
                                    .font(.headline)
                                Text("example@email.com")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: Text("通知設定")) {
                        SettingsRow(icon: "bell.fill", iconColor: .red, text: "通知")
                    }
                    
                    NavigationLink(destination: Text("アプリの設定")) {
                        SettingsRow(icon: "gearshape.fill", iconColor: .gray, text: "アプリの設定")
                    }
                }
                
                Section(header: Text("その他")) {
                    NavigationLink(destination: Text("友達招待")) {
                        SettingsRow(icon: "person.2.fill", iconColor: .green, text: "友達を招待")
                    }
                    
                    NavigationLink(destination: Text("ヘルプ")) {
                        SettingsRow(icon: "questionmark.circle.fill", iconColor: .blue, text: "ヘルプ")
                    }
                    
                    NavigationLink(destination: Text("利用規約")) {
                        SettingsRow(icon: "doc.text.fill", iconColor: .gray, text: "利用規約")
                    }
                    
                    NavigationLink(destination: Text("プライバシーポリシー")) {
                        SettingsRow(icon: "shield.fill", iconColor: .gray, text: "プライバシーポリシー")
                    }
                }
                
                Section {
                    Button(action: { /* ログアウト処理 */ }) {
                        Text("ログアウト")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("設定")
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .frame(width: 24, height: 24)
            Text(text)
        }
    }
}

#Preview {
    SettingsView()
}
