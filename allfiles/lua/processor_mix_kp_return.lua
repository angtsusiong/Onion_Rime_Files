--- @@ 合併 lua_tran_kp 和 return 上屏模式切換
--[[
（bopomo_onion_double）
使 lua 之 mf_translator 數字和計算機功能可用小鍵盤輸入
使 return 上屏模式切換
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
  -- local namespace2 = "lua_custom_phrase"
  -- local path = rime_api.get_user_data_dir()
  env.prefix = config:get_string(namespace1 .. "/prefix") or ""
  -- env.textdict = config:get_string(namespace2 .. "/user_dict") or ""
  -- env.custom_phrase_file_name = path .. "/" .. env.textdict .. ".txt" or ""
  -- log.info("lua_custom_phrase: \'" .. env.textdict .. ".txt\' Initilized!")  -- 日誌中提示已經載入 txt 短語
  -- env.prefix = config:get_string("mf_translator/prefix")
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

-- local function mix_kp_return(key, env)
local function processor(key, env)
  local engine = env.engine
  local context = engine.context
  -- local schema = engine.schema -- init
  local c_input = context.input
  local comp = context.composition
  -- local config = schema.config -- init
  -- local prefix = config:get_string("mf_translator/prefix") -- init
  local seg = comp:back()
  -- local g_c_t = context:get_commit_text()
  local o_ascii_mode = context:get_option("ascii_mode")
  local r_mode = context:get_option("return_mode")

  -- local check_pre = string.match(c_input, "`[-]?[.]?$")
  -- local check_num_cal = string.match(c_input, "`[-]?[.]?%d+%.?%d*$") or
  --                       string.match(c_input, "`[-.rq(]?[%d.]+[-+*/^asrvxqw()][-+*/^asrvxqw().%d]*$")

  local check_pre = string.match(c_input, env.prefix .. "[-]?[.]?$")
  local check_num_cal = string.match(c_input, env.prefix .. "[-]?[.]?%d+%.?%d*$") or
                        string.match(c_input, env.prefix .. "[-.rq(]?[%d.]+[-+*/^asrvxqw()][-+*/^asrvxqw().%d]*$")
  -- local key_kp = key:repr():match("KP_([%d%a]+)")  -- KP_([ASDM%d][%a]*)
  -- local kp_p = env.kp_pattern[key_kp]

  -- local kp_check = key:repr():match("KP_")
  -- local key_num = key:repr():match("KP_([0-9])")
  -- local key_add = key:repr():match("KP_Add")
  -- local key_sub = key:repr():match("KP_Subtract")
  -- local key_mul = key:repr():match("KP_Multiply")
  -- local key_div = key:repr():match("KP_Divide")
  -- local key_dec = key:repr():match("KP_Decimal")

---------------------------------------------------------------------------

  if o_ascii_mode then
    return 2

  --- prevent segmentation fault (core dumped) （避免進入死循環，有用到 seg=comp:back() 建議使用去排除？）
  elseif comp:empty() then
    return 2

  --- pass release ctrl alt super
  elseif key:release() or key:ctrl() or key:alt() or key:super() then
    return 2

---------------------------------------------------------------------------
--[[
以下開始使得純數字和計算機時，於小鍵盤可輸入數字和運算符
--]]

  elseif seg:has_tag("mf_translator") and key:repr() ~= "Return" and key:repr() ~= "KP_Enter" then
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
      -- elseif env.textdict == "" then
      --   return 2
      -- elseif key:repr() == "p" then
      --   generic_open(env.custom_phrase_file_name)
      --   context:clear()
      --   return 1
      end

    end

---------------------------------------------------------------------------
--[[
以下 return 上屏模式切換
--]]
  elseif not r_mode then
    return 2

  elseif key:repr() ~= "Return" and key:repr() ~= "KP_Enter" then
    return 2

  elseif context:is_composing() then
    engine:commit_text(c_input)
    context:clear()
    return 1

---------------------------------------------------------------------------
--[[
以下條列式寫法
--]]

  -- --- 此項如沒開啟，bo_mixin3 會有問題！
  -- --- 但開啟會遇到輸入過長無法再用小鍵盤輸入！
  -- elseif not seg:has_tag("lua") then
  -- -- elseif kp_p == nil and not seg:has_tag("lua") then
  -- -- elseif not kp_check and not seg:has_tag("lua") then
  --   return 2

  -- --- 先過濾鍵位是否為小鍵位，不是則跳掉，或可增效能？
  -- --- 下方 string.match 不能尋找 kp_p 值為 nil，會報錯！！！故此項須保留！
  -- elseif kp_p == nil then
  -- -- elseif not kp_check then
  -- -- elseif not key_num and not key_add and not key_sub and not key_mul and not key_div and not key_dec then
  --   return 2

  -- elseif not check_pre and not check_num_cal then
  --   return 2


  -- elseif string.match(kp_p, "[%d.-]") then
  --   context.input = c_input .. kp_p
  --   return 1

  -- --- 防開頭後接[+*/]
  -- elseif check_pre then
  --   return 2

  -- elseif string.match(kp_p, "[+*/]") then
  --   context.input = c_input .. kp_p
  --   return 1

---------------------------------------------------------------------------
--[[
以下展開寫法
--]]

  -- elseif key_num then
  --   context.input = c_input .. key_num
  --   return 1

  -- elseif key_sub then
  --   context.input = c_input .. "-"
  --   return 1

  -- elseif key_dec then
  --   context.input = c_input .. "."
  --   return 1

  -- --- 防開頭後接以下符號
  -- elseif check_pre then
  --   return 2

  -- elseif key_add then
  --   context.input = c_input .. "+"
  --   return 1

  -- elseif key_mul then
  --   context.input = c_input .. "*"
  --   return 1

  -- elseif key_div then
  --   context.input = c_input .. "/"
  --   return 1

---------------------------------------------------------------------------

  end

  return 2 -- kNoop
end

-- return mix_kp_return
-- return { func = processor }
return { init = init, func = processor }