local addonName, ns = ...
local locale = GetLocale()
if locale ~= "zhCN" and locale ~= "zhTW" then return end
local L = ns.L
local cn = locale == "zhCN"

L.Description  = cn and "Ã©Å¡ÂÃ¨ÂºÂ«Ã¦Å’â€¡Ã§Â¤ÂºÃ¥â„¢Â¨"      or "Ã©Å¡Â±Ã¨ÂºÂ«Ã¦Å’â€¡Ã§Â¤ÂºÃ¥â„¢Â¨"
L.ReleaseNotes = cn and "Ã¦â€ºÂ´Ã¦â€“Â°Ã¦â€”Â¥Ã¥Â¿â€”"        or "Ã¦â€ºÂ´Ã¦â€“Â°Ã¦â€”Â¥Ã¨ÂªÅ’"
L.Reset        = cn and "Ã©â€¡ÂÃ§Â½Â®Ã¤Â¸ÂºÃ©Â»ËœÃ¨Â®Â¤"       or "Ã©â€¡ÂÃ§Â½Â®Ã§â€šÂºÃ©Â ÂÃ¨Â¨Â­"

L.Stealth     = cn and "Ã¦Â½Å“Ã¨Â¡Å’"    or "Ã¦Â½â€ºÃ¨Â¡Å’"
L.ShadowDance = cn and "Ã¥Â½Â±Ã¨Ë†Å¾"    or "Ã¥Â½Â±Ã¨Ë†Å¾"

L.Settings = cn and "Ã¨Â®Â¾Ã§Â½Â®"        or "Ã¨Â¨Â­Ã¥Â®Å¡"
L.Messages = cn and "Ã¦Â¶Ë†Ã¦ÂÂ¯"        or "Ã¨Â¨Å Ã¦ÂÂ¯"

L.EnableOnStealth     = cn and "Ã¦Â½Å“Ã¨Â¡Å’Ã¦â€”Â¶Ã¥ÂÂ¯Ã§â€Â¨" or "Ã¦Â½â€ºÃ¨Â¡Å’Ã¦â„¢â€šÃ¥â€¢Å¸Ã§â€Â¨"
L.EnableOnShadowDance = cn and "Ã¥Â½Â±Ã¨Ë†Å¾Ã¦â€”Â¶Ã¥ÂÂ¯Ã§â€Â¨" or "Ã¥Â½Â±Ã¨Ë†Å¾Ã¦â„¢â€šÃ¥â€¢Å¸Ã§â€Â¨"

L.FloatingText  = cn and "Ã¦Â¼â€šÃ¦ÂµÂ®Ã¦â€“â€¡Ã¥Â­â€”"  or "Ã¦Â¼â€šÃ¦ÂµÂ®Ã¦â€“â€¡Ã¥Â­â€”"
L.IndicatorIcon = cn and "Ã¦Å’â€¡Ã§Â¤ÂºÃ¥â€ºÂ¾Ã¦Â â€¡"  or "Ã¦Å’â€¡Ã§Â¤ÂºÃ¥Å“â€“Ã§Â¤Âº"
L.ScreenColor   = cn and "Ã¥Â±ÂÃ¥Â¹â€¢Ã©Â¢Å“Ã¨â€°Â²"  or "Ã¨Å¾Â¢Ã¥Â¹â€¢Ã©Â¡ÂÃ¨â€°Â²"
L.Vignette      = cn and "Ã¦Â¸ÂÃ¥ÂËœÃ¦â€¢Ë†Ã¦Å¾Å“"  or "Ã¦Â¼Â¸Ã¥Â±Â¤Ã¦â€¢Ë†Ã¦Å¾Å“"
L.Highlight     = cn and "Ã©Â«ËœÃ¤ÂºÂ®"      or "Ã©Â«ËœÃ¤ÂºÂ®"
L.Appearance    = cn and "Ã¥Â¤â€“Ã¨Â§â€š"      or "Ã¥Â¤â€“Ã¨Â§â‚¬"

L.Enable     = cn and "Ã¥ÂÂ¯Ã§â€Â¨"     or "Ã¥â€¢Å¸Ã§â€Â¨"
L.Color      = cn and "Ã©Â¢Å“Ã¨â€°Â²"     or "Ã©Â¡ÂÃ¨â€°Â²"
L.Size       = cn and "Ã¥Â¤Â§Ã¥Â°Â"     or "Ã¥Â¤Â§Ã¥Â°Â"
L.Opacity    = cn and "Ã©â‚¬ÂÃ¦ËœÅ½Ã¥ÂºÂ¦"   or "Ã©â‚¬ÂÃ¦ËœÅ½Ã¥ÂºÂ¦"
L.OffsetX    = cn and "Ã¥ÂÂÃ§Â§Â» X"   or "Ã¥ÂÂÃ§Â§Â» X"
L.OffsetY    = cn and "Ã¥ÂÂÃ§Â§Â» Y"   or "Ã¥ÂÂÃ§Â§Â» Y"
L.Thickness  = cn and "Ã¥Å½Å¡Ã¥ÂºÂ¦"     or "Ã¥Å½Å¡Ã¥ÂºÂ¦"
L.CustomText = cn and "Ã¨â€¡ÂªÃ¥Â®Å¡Ã¤Â¹â€°Ã¦â€“â€¡Ã¥Â­â€”" or "Ã¨â€¡ÂªÃ¨Â¨â€šÃ¦â€“â€¡Ã¥Â­â€”"
L.Style      = cn and "Ã¦Â Â·Ã¥Â¼Â"     or "Ã¦Â¨Â£Ã¥Â¼Â"
L.Layer      = cn and "Ã¥Â±â€šÃ§ÂºÂ§"     or "Ã¥Â±Â¤Ã§Â´Å¡"

L.Description  = cn and "隐身指示器"      or "隱身指示器"
L.ReleaseNotes = cn and "更新日志"        or "更新日誌"
L.Reset        = cn and "重置为默认"       or "重置為預設"

L.Stealth     = cn and "潜行"    or "潛行"
L.ShadowDance = cn and "影舞"    or "影舞"

L.Settings = cn and "设置"        or "設定"
L.Messages = cn and "消息"        or "訊息"

L.EnableOnStealth     = cn and "潜行时启用" or "潛行時啟用"
L.EnableOnShadowDance = cn and "影舞时启用" or "影舞時啟用"

L.FloatingText  = cn and "浮动文字"  or "浮動文字"
L.IndicatorIcon = cn and "指示图标"  or "指示圖示"
L.ScreenColor   = cn and "屏幕颜色"  or "螢幕顏色"
L.Vignette      = cn and "渐变效果"  or "漸層效果"
L.Highlight     = cn and "高亮"      or "高亮"
L.Appearance    = cn and "外观"      or "外觀"

L.Enable     = cn and "启用"     or "啟用"
L.Color      = cn and "颜色"     or "顏色"
L.Size       = cn and "大小"     or "大小"
L.Opacity    = cn and "透明度"   or "透明度"
L.OffsetX    = cn and "偏移 X"   or "偏移 X"
L.OffsetY    = cn and "偏移 Y"   or "偏移 Y"
L.Thickness  = cn and "厚度"     or "厚度"
L.CustomText = cn and "自定义文字" or "自訂文字"
L.Style      = cn and "样式"     or "樣式"
L.Layer      = cn and "层级"     or "層級"

L.DefaultMessage     = cn and "潜行" or "潛行"
L.ShadowDanceMessage = cn and "影舞" or "影舞"

L.ShroudOfConcealment = cn and "匿藏之幕"     or "匿藏之幕"
L.Countdown           = cn and "聊天倒计时"   or "聊天倒數計時"
L.ChatChannel         = cn and "聊天频道"     or "聊天頻道"
L.ShroudMessage       = cn and "倒计时消息"         or "倒数计时讯息"
L.ShroudInterval      = cn and "间隔模式"     or "间隔模式"
L.ShroudIntervalDesc  = cn and "仅在开始、每5秒和最后5秒发送" or "仅在开始、每5秒和最后5秒发送"
L.ShroudOnStart       = cn and "开始消息"     or "开始讯息"
L.ShroudOnEnd         = cn and "结束消息"     or "结束讯息"
L.TimeRemainingHint   = cn and "%t = 剩余时间" or "%t = 剩余时间"
