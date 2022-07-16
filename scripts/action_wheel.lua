---@class ActionWheelClass アクションホイールを制御するクラス
---@field MainPage Page アクションホイールのメインページ
---@field MainPageActions table メインページのアクションを格納するテーブル
---@field ConfigPage Page アクションホイールの設定ページ
---@field ConfigPageAction table 設定ページのアクションを格納するテーブル

ActionWheelClass = {}

MainPage = action_wheel:createPage("main_page")
MainPageActions = {}
ConfigPage = action_wheel:createPage("config_page")
ConfigPageActions = {}

--メインページのアクションの設定
MainPage:newAction()

--アクション1. 「ニャー」と鳴く（スマイル）
MainPageActions[1] = MainPage:newAction(1)
MainPageActions[1]:title("「ニャー」と鳴く（スマイル）"):color(255 / 255, 85 / 255, 255 / 255):item("cod"):hoverColor(1, 1, 1)


--アクション2. 「ニャー」と鳴く（ウィンク）
MainPageActions[2] = MainPage:newAction(2)
MainPageActions[2]:title("「ニャー」と鳴く（ウィンク）"):color(255 / 255, 85 / 255, 255 / 255):item("cod"):hoverColor(1, 1, 1)

--アクション3. 「ニャー」と鳴く（キラキラ）
MainPageActions[3] = MainPage:newAction(3)
MainPageActions[3]:title("「ニャー」と鳴く（キラキラ）"):color(255 / 255, 85 / 255, 255 / 255):item("cod"):hoverColor(1, 1, 1)

--アクション4. おすわり
MainPageActions[4] = MainPage:newAction(4)
MainPageActions[4]:title("おすわり"):color(255 / 255, 85 / 255, 255 / 255):item("oak_stairs"):hoverColor(1, 1, 1)

--アクション5. ブルブル
MainPageActions[5] = MainPage:newAction(5)
MainPageActions[5]:title("ブルブル"):color(255 / 255, 85 / 255, 255 / 255):item("water_bucket"):hoverColor(1, 1, 1)

--アクション6. 設定を開く
MainPageActions[6] = MainPage:newAction(6)
MainPageActions[6]:title("設定（クリック）"):color(200 / 255, 200 / 255, 200 / 255):item("comparator"):hoverColor(1, 1, 1)

action_wheel:setPage(MainPage)

return ActionWheelClass