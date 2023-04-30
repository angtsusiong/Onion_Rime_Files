--- @@ mix30_nil_comment_up_filter
--[[
（onion-array30）
合併 array30_nil_filter 和 array30_comment_filter 和 array30_spaceup_filter，三個 lua filter 太耗效能。
--]]




--- 以下新的寫法

----------------

local change_comment = require("filter_cand/change_comment")

----------------
-- local M={}
-- local function init(env)
-- function M.init(env)
-- end

-- function M.fini(env)
-- end

-- local function mix30_nil_comment_up_filter(inp, env)
local function filter(inp, env)
-- function M.func(inp, env)
  local engine = env.engine
  local context = engine.context
  local s_c_f_p_s = context:get_option("simplify_comment")
  local s_up = context:get_option("1_2_straight_up")
  local find_prefix = context.input  -- 原始未轉換輸入碼
  -- local start = context:get_preedit().sel_start
  local _end = context:get_preedit().sel_end
  local array30_nil_cand = Candidate("array30nil", 0, _end, "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len("⎔")等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
  -- local array30_nil_cand = Candidate("array30nil", 0, string.len(find_prefix) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len("⎔")等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
  local check_ns = string.match(find_prefix, "^[a-z.,/;][a-z.,/;]?[a-z.,/;']?[a-z.,/;']?[i']?$" )
  local check_s1 = string.match(find_prefix, "^[a-z,./;][a-z,./;]? $" )
  -- local check_s2 = string.match(find_prefix, "^a[k,] $" )
  -- local check_s3 = string.match(find_prefix, "^lr $" )
  -- local check_s4 = string.match(find_prefix, "^ol $" )
  -- local check_s5 = string.match(find_prefix, "^q[ka] $" )
  -- local check_s6 = string.match(find_prefix, "^%.b $" )
  -- local check_s7 = string.match(find_prefix, "^/%. $" )
  -- local check_s8 = string.match(find_prefix, "^pe $" )
  local check_s2 = string.match(find_prefix, "^a[k,] $" ) or
                   string.match(find_prefix, "^lr $" ) or
                   string.match(find_prefix, "^ol $" ) or
                   string.match(find_prefix, "^q[ka] $" ) or
                   string.match(find_prefix, "^%.b $" ) or
                   string.match(find_prefix, "^/%. $" ) or
                   string.match(find_prefix, "^pe $" )
  local check_wu = string.match(find_prefix, "^sf $" )
  local check_ji = string.match(find_prefix, "^lb $" )
  local check_kong = string.match(find_prefix, "^ou $" )
  -- local check_www = string.match(find_prefix, "^www[.].*$" )  -- 直接判別 comment 即可

  for cand in inp:iter() do
    if string.match(cand.text, "^⎔%d$" ) then
      -- local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
      -- array30_nil_cand.preedit = array30_preedit
      array30_nil_cand.preedit = cand.preedit
      yield(array30_nil_cand)
    elseif string.match(cand.comment, "〔URL〕" ) then
    -- elseif check_www and string.match(cand.comment, "〔URL〕" ) then  -- 直接判別 comment 即可
      yield(cand)
    else
      if s_up then

        if check_ns then  -- 不含空格
          yield( s_c_f_p_s and change_comment(cand,"") or cand )
        else  -- 最後有空格
          local cand_filtr = check_s1 and not string.match(cand.comment, "▪" ) and cand or
                             -- (check_s2 or check_s3 or check_s4 or check_s5 or check_s6 or check_s7 or check_s8) and cand or
                             check_s2 and cand or
                             check_wu and string.match(cand.text, "毋" ) and cand or
                             check_ji and string.match(cand.text, "及" ) and cand or
                             check_kong and string.match(cand.text, "○" ) and cand
          if cand_filtr then
            yield(cand_filtr)  -- yield(nil)不能為空，否則報錯。
          end
        end

        -- if check_ns then
        --   yield( s_c_f_p_s and change_comment(cand,"") or cand )
        -- elseif check_s1 and not string.match(cand.comment, "▪" ) then
        --   yield(cand)  --空格後，該字編碼不含「▪」直接上屏。
        -- elseif check_s2 or check_s3 or check_s4 or check_s5 or check_s6 or check_s7 or check_s8 then
        --   yield(cand)  --同時含有「▫」和「▪」編碼的字，空格後，該字某編碼下可直接上屏，某編碼下不能直接上屏。
        -- elseif check_wu and string.match(cand.text, "毋" ) then
        --   yield(cand)  --同時含有「▫」和「▪」編碼的字，但該編碼不只一個字。
        -- elseif check_ji and string.match(cand.text, "及" ) then
        --   yield(cand)  --同時含有「▫」和「▪」編碼的字，但該編碼不只一個字。
        -- elseif check_kong and string.match(cand.text, "○" ) then
        --   yield(cand)  --同時含有「▫」和「▪」編碼的字，但該編碼不只一個字。

        -- elseif (string.match(find_prefix, "^www%..*$")) then
        --   yield(cand)
        -- elseif (string.match(find_prefix, "`.*$" )) or (string.match(find_prefix, "^w[0-9]$" ))  or (string.match(find_prefix, "^[a-z][-_.0-9a-z]*@.*$" )) or (string.match(find_prefix, "^(www[.]|https?:|ftp:|mailto:|file:).*$" )) then
        --   yield(cand)

        -- end

      elseif not s_up then
        yield( s_c_f_p_s and change_comment(cand,"") or cand )
      end

    end
  end

end
----------------
-- return mix30_nil_comment_up_filter
return { func = filter }
-- return M
----------------





--- 以下舊的寫法
--[[
local function mix30_nil_comment_up_filter(input, env)
  local s_c_f_p_s = env.engine.context:get_option("simplify_comment")
  local s_up = env.engine.context:get_option("1_2_straight_up")
  local find_prefix = env.engine.context.input  -- 原始未轉換輸入碼
  local _end = env.engine.context:get_preedit().sel_end
  local array30_nil_cand = Candidate("array30nil", 0, _end, "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len('⎔')等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
  local check_ns = string.match(find_prefix, "^[a-z.,/;][a-z.,/;]?[a-z.,/;']?[a-z.,/;']?[i']?$" )
  local check_s1 = string.match(find_prefix, "^[a-z,./;][a-z,./;]? $" )
  local check_s2 = string.match(find_prefix, "^a[k,] $" ) or
                   string.match(find_prefix, "^lr $" ) or
                   string.match(find_prefix, "^ol $" ) or
                   string.match(find_prefix, "^q[ka] $" ) or
                   string.match(find_prefix, "^%.b $" ) or
                   string.match(find_prefix, "^/%. $" ) or
                   string.match(find_prefix, "^pe $" )
  local check_wu = string.match(find_prefix, "^sf $" )
  local check_ji = string.match(find_prefix, "^lb $" )
  local check_kong = string.match(find_prefix, "^ou $" )

  if (not s_c_f_p_s) then
  -- if (not s_c_f_p_s) or (string.match(find_prefix, "`" )) then
    for cand in input:iter() do
      -- local find_prefix = env.engine.context.input  -- 原始未轉換輸入碼
      -- local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
      -- local array30_nil_cand = Candidate("array30nil", 0, _end, "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len("⎔")等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      -- local array30_nil_cand = Candidate("array30nil", 0, string.len(find_prefix) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len("⎔")等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      if (string.match(cand.text, '^⎔%d$' )) then
        array30_nil_cand.preedit = cand.preedit
        -- array30_nil_cand.preedit = array30_preedit
        yield(array30_nil_cand)
      else
        if (s_up) then
          if (check_ns) then
            yield(cand)
          elseif (check_s1) and (not string.match(cand.comment, "▪" )) then
            yield(cand)
          elseif (check_s2) then
            yield(cand)
          elseif (check_wu) and (string.match(cand.text, "毋" )) then
            yield(cand)
          elseif (check_ji) and (string.match(cand.text, "及" )) then
            yield(cand)
          elseif (check_kong) and (string.match(cand.text, "○" )) then
            yield(cand)
          -- elseif (string.match(find_prefix, "^www%..*$")) then
          --   yield(cand)
          -- elseif (string.match(find_prefix, "`.*$" )) or (string.match(find_prefix, "^w[0-9]$" ))  or (string.match(find_prefix, "^[a-z][-_.0-9a-z]*@.*$" )) or (string.match(find_prefix, "^(www[.]|https?:|ftp:|mailto:|file:).*$" )) then
          --   yield(cand)
          end
        elseif (not s_up) then
          yield(cand)
        end
      end
    end
  else
    for cand in input:iter() do
      -- local find_prefix = env.engine.context.input  -- 原始未轉換輸入碼
      -- local array30_preedit = cand.preedit  -- 轉換後輸入碼，如：ㄅㄆㄇㄈ、1-2⇡9⇡
      -- local array30_nil_cand = Candidate("array30nil", 0, _end, "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len("⎔")等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      -- local array30_nil_cand = Candidate("array30nil", 0, string.len(find_prefix) , "", "⎔")  -- 選擇空碼"⎔"效果為取消，測試string.len("⎔")等於「3」，如設置「4」為==反查時就不會露出原英文編碼（"⎔"只出現在一二碼字）
      if (string.match(cand.text, '^⎔%d$' )) then
        array30_nil_cand.preedit = cand.preedit
        -- array30_nil_cand.preedit = array30_preedit
        yield(array30_nil_cand)
      else
        if (s_up) then
          if (check_ns) then
            cand:get_genuine().comment = ""
            yield(cand)
          elseif (check_s1) and (not string.match(cand.comment, "▪" )) then
            -- cand:get_genuine().comment = ""  --直上不用特別遮
            yield(cand)
          elseif (check_s2) then
            -- cand:get_genuine().comment = ""  --直上不用特別遮
            yield(cand)
          elseif (check_wu) and (string.match(cand.text, "毋" )) then
            -- cand:get_genuine().comment = ""  --直上不用特別遮
            yield(cand)
          elseif (check_ji) and (string.match(cand.text, "及" )) then
            -- cand:get_genuine().comment = ""  --直上不用特別遮
            yield(cand)
          elseif (check_kong) and (string.match(cand.text, "○" )) then
            -- cand:get_genuine().comment = ""  --直上不用特別遮
            yield(cand)
          -- elseif (string.match(find_prefix, "^www%..*$")) then
          --   yield(cand)
          -- elseif (string.match(find_prefix, "`.*$" )) or (string.match(find_prefix, "^w[0-9]$" ))  or (string.match(find_prefix, "^[a-z][-_.0-9a-z]*@.*$" )) or (string.match(find_prefix, "^(www[.]|https?:|ftp:|mailto:|file:).*$" )) then
          --   yield(cand)
          end
        elseif (not s_up) then
          cand:get_genuine().comment = ""
          yield(cand)
        end
      end
    end
  end
end

return mix30_nil_comment_up_filter
--]]