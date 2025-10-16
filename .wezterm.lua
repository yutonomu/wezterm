-- =====================================================================
-- ■ 0. セットアップ (Setup)
-- =====================================================================
-- WezTermのAPIを読み込みます
local wezterm = require 'wezterm'
local act = wezterm.action

-- 設定を保持するためのテーブルを用意します
local config = wezterm.config_builder()

-- =====================================================================
-- ■ 1. 外観 (Appearance)
-- =====================================================================
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font_with_fallback({
  '0xProto Nerd Font Propo',
  'UDEV Gothic NF',
  'Yu Gothic UI',
})
config.font_size = 12.0
config.window_background_opacity = 0.95
config.window_padding = { left = 10, right = 10, top = 10, bottom = 5 }
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "RESIZE"

-- =====================================================================
-- ■ 2. 挙動 (Behavior) - 最も重要な設定箇所
-- =====================================================================
config.scrollback_lines = 5000
config.automatically_reload_config = true
config.default_prog = {'C:\\Program Files\\Git\\bin\\bash.exe'}


-- =====================================================================
-- ■ 3. キーバインド (Keybindings)
-- =====================================================================
-- キーバインドはデフォルトの挙動（新しいタブも default_prog を使う）で良いため、
-- シンプルな設定に戻しています。
config.keys = {
  { key = 't', mods = 'CTRL', action = act.SpawnTab 'DefaultDomain' },
  { key = 'w', mods = 'CTRL', action = act.CloseCurrentPane{ confirm = false } },
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },

  { key = '=', mods = 'ALT|SHIFT', action = act.SplitVertical{ domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'ALT|SHIFT', action = act.SplitHorizontal{ domain = 'CurrentPaneDomain' } },
  { key = 'LeftArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT', action = act.ActivatePaneDirection 'Down' },
  { key = 'Tab', mods = 'CTRL',        action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT',  action = act.ActivateTabRelative(-1) },
}

-- =====================================================================
-- ■ 4. 起動メニュー (Launch Menu)
-- =====================================================================
config.launch_menu = {
  {
    label = 'Ubuntu (WSL)',
    args = {
      'wsl.exe',
      '-d', 'Ubuntu',
      -- '-e' は、続くコマンドをWSL内で実行するオプション
      '-e', 'bash',
      -- '-c' は、bashに続く文字列をコマンドとして実行させるオプション
      '-c', 'cd ~ && exec bash'
    }
  },
  { label = 'Git Bash',     args = {'C:\\Program Files\\Git\\bin\\bash.exe'} },
  { label = 'PowerShell',   args = {'powershell.exe', '-NoLogo'} },
}

-- =====================================================================
-- ■ 5. 環境変数設定 (Environment Variables) - 参考
-- =====================================================================
-- ※この設定はWindows側のプロセス（Git BashやPowerShell）にのみ影響します。
-- WSL側の環境変数は、WSL内の ~/.bashrc や ~/.profile で設定するのが一般的です。
local home = os.getenv("USERPROFILE")
config.set_environment_variables = {
  LANG = 'ja_JP.UTF-8',
  LC_ALL = 'ja_JP.UTF-8',
  PATH = home .. '/.cargo/bin;' .. os.getenv("PATH"),
}


-- 最後に、完成した設定をWezTermに返します
return config