import XCTest

class AppUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    // 各デバイスタイプでのテストを実行する関数
    func testOnDevice(_ deviceType: String) {
        // メインフロー
        testMainNavigationFlow()
        
        // データ編集フロー
        testDataEditFlow()
        
        // 設定画面フロー
        testSettingsFlow()
        
        // メモリ負荷テスト
        testMemoryStress()
        
        print("✅ テスト完了: \(deviceType)")
    }
    
    func testMainNavigationFlow() {
        // タブ間の移動テスト
        let calendarTab = app.tabBars.buttons["カレンダー"]
        let settingsTab = app.tabBars.buttons["設定"]
        
        calendarTab.tap()
        XCTAssertTrue(calendarTab.isSelected)
        
        settingsTab.tap()
        XCTAssertTrue(settingsTab.isSelected)
    }
    
    func testDataEditFlow() {
        // カレンダータブに移動
        app.tabBars.buttons["カレンダー"].tap()
        
        // データ追加/編集
        let dayCell = app.buttons.matching(identifier: "dayCell").firstMatch
        dayCell.tap()
        
        // 気分選択
        let moodButtons = app.buttons.matching(identifier: "moodButton")
        moodButtons.element(boundBy: 0).tap()
        
        // 睡眠時間調整
        let sleepSlider = app.sliders["sleepSlider"]
        sleepSlider.adjust(toNormalizedSliderPosition: 0.5)
        
        // アクティビティ選択
        app.buttons["早起き"].tap()
        app.buttons["運動"].tap()
        
        // 保存
        app.buttons["保存"].tap()
        
        // 編集して削除
        dayCell.tap()
        app.buttons["削除"].tap()
        app.alerts["記録を削除"].buttons["削除"].tap()
    }
    
    func testSettingsFlow() {
        // 設定タブに移動
        app.tabBars.buttons["設定"].tap()
        
        // 各設定項目をタップ
        let settingsLinks = [
            "アカウント設定",
            "通知",
            "アプリの設定",
            "友達を招待",
            "ヘルプ",
            "利用規約",
            "プライバシーポリシー"
        ]
        
        for link in settingsLinks {
            app.buttons[link].tap()
            app.navigationBars.buttons.element(boundBy: 0).tap() // 戻る
        }
        
        // ログアウトボタン
        app.buttons["ログアウト"].tap()
    }
    
    func testMemoryStress() {
        // メモリ負荷テスト
        for _ in 1...50 {
            app.tabBars.buttons["カレンダー"].tap()
            app.tabBars.buttons["設定"].tap()
        }
        
        // 大量のデータ入力
        app.tabBars.buttons["カレンダー"].tap()
        for _ in 1...20 {
            let dayCell = app.buttons.matching(identifier: "dayCell").firstMatch
            dayCell.tap()
            app.buttons["保存"].tap()
        }
    }
}

// 各デバイスでのテスト実行
extension AppUITests {
    func testOniPhone() {
        // iPhone 14 Pro
        testOnDevice("iPhone 14 Pro")
    }
    
    func testOniPad() {
        // iPad Air (5th generation)
        testOnDevice("iPad Air")
    }
    
    func testOnMac() {
        // MacBook Pro
        testOnDevice("Mac")
    }
}
