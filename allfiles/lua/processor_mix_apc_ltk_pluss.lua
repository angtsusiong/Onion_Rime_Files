--- @@ mix_apc_ltk_pluss
--[[
（bopomo_onionplus_space）
合併 ascii_punct_change、lua_tran_kp 並增加功能
使初始空白可以直接上屏
於注音方案改變在非 ascii_mode 時 ascii_punct 轉換後按 '<' 和 '>' 能輸出 ',' 和 '.'
新增快捷鍵開啟檔案/程式/網站
--]]

----------------------------------------------------------------------------------------
local generic_open = require("p_components/p_generic_open")
----------------------------------------------------------------------------------------

local function init(env)
  local engine = env.engine
  local schema = engine.schema
  local config = schema.config
  local namespace1 = "mf_translator"
  local namespace2 = "lua_custom_phrase"
  local path = rime_api.get_user_data_dir()
  env.prefix = config:get_string(namespace1 .. "/prefix") or ""
  env.textdict = config:get_string(namespace2 .. "/user_dict") or ""
  env.custom_phrase_file_name = path .. "/" .. env.textdict .. ".txt" or ""
  -- log.info("lua_custom_phrase: \'" .. env.textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
  -- env.kp_pattern = {
  --   ["0"] = "0",
  --   ["1"] = "1",
  --   ["2"] = "2",
  --   ["3"] = "3",
  --   ["4"] = "4",
  --   ["5"] = "5",
  --   ["6"] = "6",
  --   ["7"] = "7",
  --   ["8"] = "8",
  --   ["9"] = "9",
  --   ["Add"] = "+",
  --   ["Subtract"] = "-",
  --   ["Multiply"] = "*",
  --   ["Divide"] = "/",
  --   ["Decimal"] = ".",
  --  }
end

local kp_pattern = {
  ["0"] = "0",
  ["1"] = "1",
  ["2"] = "2",
  ["3"] = "3",
  ["4"] = "4",
  ["5"] = "5",
  ["6"] = "6",
  ["7"] = "7",
  ["8"] = "8",
  ["9"] = "9",
  ["Add"] = "+",
  ["Subtract"] = "-",
  ["Multiply"] = "*",
  ["Divide"] = "/",
  ["Decimal"] = ".",
 }

-- local function mix_apc_ltk_pluss(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  local c_input = context.input
  local caret_pos = context.caret_pos
  local comp = context.composition
  local seg = comp:back()
  local g_c_t = context:get_commit_text()
  local o_ascii_punct = context:get_option("ascii_punct")
  local o_ascii_mode = context:get_option("ascii_mode")

  local check_pre = string.match(c_input, "'/[-]?[.]?$")
  local check_num_cal = string.match(c_input, "'/[-]?[.]?%d+%.?%d*$") or
                        string.match(c_input, "'/[-.rq(]?[%d.]+[-+*/^asrvxqw()][-+*/^asrvxqw().%d]*$")
  -- local key_kp = key:repr():match("KP_([%d%a]+)")  -- KP_([ASDM%d][%a]*)
  -- local kp_p = env.kp_pattern[key_kp]

---------------------------------------------------------------------------

  if o_ascii_mode then
    return 2

  -- --- 該條目移到下方，這邊開啟 Shift+less 和 Shift+greater 啟始無法作用
  -- --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  -- elseif comp:empty() then
  --   return 2

  --- pass release ctrl alt super
  elseif key:release() or key:ctrl() or key:alt() or key:super() then
    return 2

---------------------------------------------------------------------------
--[[
以下特殊時 space 直上屏
--]]

  elseif key:repr() == "space" and caret_pos == 0 then
      engine:commit_text( " " )
      context:clear()
      return 1 -- kAccepted

---------------------------------------------------------------------------
--[[
以下 ascii_punct 標點轉寫
--]]

  elseif o_ascii_punct and key:repr() == "Shift+less" then
    if context:is_composing() then
      -- local cand = context:get_selected_candidate()
      -- engine:commit_text( cand.text .. "," )  -- ascii_punct 時選擇選項與其他標點不統一
      engine:commit_text( g_c_t .. "," )
    else
      engine:commit_text( "," )
    end
    context:clear()
    return 1 -- kAccepted

  elseif o_ascii_punct and key:repr() == "Shift+greater" then
    if context:is_composing() then
      -- local cand = context:get_selected_candidate()
      -- engine:commit_text( cand.text .. "." )  -- ascii_punct 時選擇選項與其他標點不統一
      engine:commit_text( g_c_t .. "." )
    else
      engine:commit_text( "." )
    end
    context:clear()
    return 1 -- kAccepted

---------------------------------------------------------------------------
--[[
以下使得純數字和計算機時，於小鍵盤可輸入數字和運算符
--]]

  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2

  elseif seg:has_tag("mf_translator") then
  -- elseif seg:has_tag("lua") then

    local key_kp = key:repr():match("KP_([%d%a]+)")  -- KP_([ASDM%d][%a]*)
    local kp_p = kp_pattern[key_kp]
    if kp_p ~= nil then
      if not check_pre and not check_num_cal then
        return 2
      elseif string.match(kp_p, "[%d.-]") then
        -- context.input = c_input .. kp_p
        context:push_input( kp_p )
        return 1
      --- 防開頭後接[+*/]
      elseif check_pre then
        return 2
      elseif string.match(kp_p, "[+*/]") then
        -- context.input = c_input .. kp_p
        context:push_input( kp_p )
        return 1
      end
    -- end

    -- elseif env.prefix == "" then  -- 前面 seg:has_tag 已確定
    --   return 2
    elseif c_input == env.prefix .. "op" then
      if key:repr() == "r" then
        generic_open("https://github.com/rime")
        context:clear()
        return 1
      elseif key:repr() == "o" then
        generic_open("https://github.com/oniondelta/Onion_Rime_Files")
        context:clear()
        return 1
      -- elseif key:repr() == "t" then  -- 測試用
      --   -- io.popen("env.custom_phrase_file_name")  -- 無效！
      --   -- engine:commit_text(env.textdict)  -- 測試用
      --   generic_open("/System/Applications/Dictionary.app")
      --   context:clear()
      --   return 1
      -- elseif key:repr() == "自行定義鍵位" then
      --   generic_open("自行定義欲開啟程式或網站")
      --   context:clear()
      --   return 1
      elseif env.textdict == "" then
        return 2
      elseif key:repr() == "p" then
        generic_open(env.custom_phrase_file_name)
        context:clear()
        return 1
      end

    end

---------------------------------------------------------------------------
--- 測試
  -- elseif seg:has_tag("japan") then
  --   if key:repr() == "space" then
  --     context:push_input( "|" )
  --     return 1
  --   end

---------------------------------------------------------------------------

  end

  return 2 -- kNoop
end

-- return mix_apc_ltk_pluss
-- return { func = processor }
return { init = init, func = processor }