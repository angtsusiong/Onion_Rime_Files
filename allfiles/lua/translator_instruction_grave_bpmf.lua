--- @@ instruction_grave_bpmf
--[[
說明注音「`」開頭之符號集
--]]
local function init(env)
  env.table_gb_1 = {
        { "    ※ 輸入【項目】每字第一個注音，調出相關符號。", "𝟎" }
      , { "   【表情】【自然】【飲食】【活動】【旅遊】【物品】", "𝟏" }
      , { "   【符號】【國旗】【微笑】【大笑】【冒汗】【喜愛】", "𝟐" }
      , { "   【討厭】【無奈】【哭泣】【冷淡】【驚訝】【生氣】", "𝟑" }
      , { "   【懷疑】【大頭】【人物】【獸面】【貓頭】【怪物】", "𝟒" }
      , { "   【五官】【手勢】【亞裔】【白人】【黑人】【非裔】", "𝟓" }
      , { "   【天氣】【下雪】【天體】【夜空】【地球】【景色】", "𝟔" }
      , { "   【景點】【名勝】【日本】【美國】【法國】【建築】", "𝟕" }
      , { "   【節日】【娛樂】【遊戲】【運動】【球具】【獎項】", "𝟖" }
      , { "   【獎牌】【食物】【正飯】【午餐】【早餐】【早點】", "𝟗" }
      , { "【中餐】【西餐】【快餐】【速食】【米飯】【麵包】", "𝟏𝟎" }
      , { "【捲物】【串物】【甜點】【零食】【飲料】【熱飲】", "𝟏𝟏" }
      , { "【酒精】【酒類】【植物】【水果】【蔬菜】【粗糧】", "𝟏𝟐" }
      , { "【花卉】【葉子】【肉類】【肉品】【牲畜】【畜牲】", "𝟏𝟑" }
      , { "【禽類】【鳥類】【魚圖】【鳥圖】【蟲圖】【器官】", "𝟏𝟒" }
      , { "【日用】【血液】【服裝】【衣物】【衣服】【褲子】", "𝟏𝟓" }
      , { "【帽子】【包包】【頭髮】【膚色】【化妝】【愛情】", "𝟏𝟔" }
      , { "【愛心】【兩性】【效果】【色塊】【宗教】【音樂】", "𝟏𝟕" }
      , { "【樂器】【時鐘】【標誌】【圖示】【圖標】【箭標】", "𝟏𝟖" }
      , { "【指示】【回收】【有害】【科學】【通訊】【電腦】", "𝟏𝟗" }
      , { "【工業】【電子】【武器】【象棋】【麻將】【骰子】", "𝟐𝟎" }
      , { "【撲克】【船隻】【飛機】【汽車】【車輛】【公交】", "𝟐𝟏" }
      , { "【城軌】【捷運】【火車】【錢財】【鈔票】【紙鈔】", "𝟐𝟐" }
      , { "【紙幣】【貨幣】【單位】【數學】【分數】【打勾】", "𝟐𝟑" }
      , { "【星號】【箭頭】【線段】【幾何】【三角】【方塊】", "𝟐𝟒" }
      , { "【圓形】【填色】【文化】【占星】【星座】【易經】", "𝟐𝟓" }
      , { "【八卦】【卦名】【天干】【地支】【干支】【節氣】", "𝟐𝟔" }
      , { "【月份】【日期】【曜日】【時間】【符碼】【標點】", "𝟐𝟕" }
      , { "【合字】【部首】【偏旁】【筆畫】【倉頡】【結構】", "𝟐𝟖" }
      , { "【拼音】【注音】【聲調】【上標】【下標】【羅馬】", "𝟐𝟗" }
      , { "【希臘】【俄語】【韓文】【(平)假名】", "𝟑𝟎" }
      , { "【幾何圖】【鞋子圖】【眼鏡圖】【工具圖】【電器圖】", "𝟑𝟏" }
      , { "【甜食圖】【餐具圖】【動物圖】【生肖圖】【家禽圖】", "𝟑𝟐" }
      , { "【魚類圖】【蟲類圖】【血型圖】【精怪圖】【月相圖】", "𝟑𝟑" }
      , { "【交通圖】【飛行器】【多媒體】【黃種人】【白種人】", "𝟑𝟒" }
      , { "【拉美裔】【拉丁裔】【棕色人】【阿拉伯】【動物臉】", "𝟑𝟓" }
      , { "【猴子頭】【咧嘴笑】【做運動】【日本菜】【食物捲】", "𝟑𝟔" }
      , { "【辦公室】【警消護】【大自然】【遊樂園】【撲克牌】", "𝟑𝟕" }
      , { "【西洋棋】【輸入法】【日用品】【單線框】【雙線框】", "𝟑𝟖" }
      , { "【色塊心】【色塊方】【色塊圓】【十字架】【星座名】", "𝟑𝟗" }
      , { "【十二宮】【太玄經】【蘇州碼】【標點直】【羅馬大】", "𝟒𝟎" }
      , { "【希臘大】【俄語大】【字母圈】【字母括】【字母方】", "𝟒𝟏" }
      , { "【字母框】【數字圈】【數字括】【數字點】【數字標】", "𝟒𝟐" }
      , { "【漢字圈】【漢字框】【漢字括】【韓文圈】【韓文括】", "𝟒𝟑" }
      , { "【假名圈】【片假名】【日本年】【填色塊】", "𝟒𝟒" }
      , { "【箭頭色(塊)】【數字色(塊)】【漢字色(塊)】", "𝟒𝟓" }
      , { "【假名半(形)】【IRO(いろは順)】", "𝟒𝟔" }
      , { "【猴子表情】【十二生肖】【交通工具】【公共運輸】", "𝟒𝟕" }
      , { "【野生動物】【日式料理】【日本料理】【日本星期】", "𝟒𝟖" }
      , { "【羅馬數字】【數字圈黑】【數字黑圈】【字母圈大】", "𝟒𝟗" }
      , { "【字母括大】【字母黑圈】【字母圈黑】【字母黑方】", "𝟓𝟎" }
      , { "【字母方黑】【字母框黑】【字母黑框】【易經卦名】", "𝟓𝟏" }
      , { "【六十四卦】【六十四卦名】【羅馬數字大】", "𝟓𝟐" }
      , { "【運動ㄋㄩ(女)】【運動ㄋㄢ(男)】", "𝟓𝟑" }
      , { "【精怪ㄋㄩ(女)】【精怪ㄋㄢ(男)】", "𝟓𝟒" }
      , { "【 a 假名】【 i 假名】【 u 假名】【 e 假名】【 o 假名】", "𝟓𝟓" }
      , { "【 k 假名】【 g 假名】【 s 假名】【 z 假名】【 t 假名】", "𝟓𝟔" }
      , { "【 d 假名】【 n 假名】【 h 假名】【 b 假名】【 p 假名】", "𝟓𝟕" }
      , { "【 m 假名】【 y 假名】【 r 假名】【 w 假名】", "𝟓𝟖" }
      , { "｢圈｣｢框｣｢括｣數字字母：【 0 ~ 10 】【 1-0 ~ 5-0 】【 a ~ z 】", "𝟓𝟗" }
      , { "===========  結束  ===========    ", "𝟔𝟎" }
      , { "", "𝟔𝟏" }
      , { "", "𝟔𝟐" }
      , { "", "𝟔𝟑" }
      , { "", "𝟔𝟒" }
      , { "", "𝟔𝟓" }
      , { "", "𝟔𝟔" }
      , { "", "𝟔𝟕" }
      , { "", "𝟔𝟖" }
      , { "", "𝟔𝟗" }
      , { "", "𝟕𝟎" }
  }
  env.table_gb_2 = {
        { "   〖 a ~ z 〗字母變化      ※ 以下 顏文字：", "𝟘" }
      , { "   〖 1 〗開心 〖 2 〗喜歡 〖 3 〗傷心", "𝟙" }
      , { "   〖 4 〗生氣 〖 5 〗驚訝 〖 6 〗無奈", "𝟚" }
      , { "   〖 7 〗喜     〖 8 〗樂     〖 9 〗怒", "𝟛" }
      , { "   〖 0 〗指示和圖示          〖 - 〗回話", "𝟜" }
      , { "    ===========  結束  ===========    ", "𝟝" }
      , { "", "𝟞" }
      , { "", "𝟟" }
      , { "", "𝟠" }
      , { "", "𝟡" }
      , { "", "𝟙𝟘" }
  }
end

-- local function instruction_grave_bpmf(input, seg)
local function translate(input, seg, env)
  -- local check_grave = string.match(input, "^`$")
  -- local check_grave2 = string.match(input, "^``$")

  -- if input:find("^`$") then
  -- if check_grave then
  if input == "`" then
    -- for cand in input:iter() do
    --   yield(cand)
    -- end
    for k, v in ipairs(env.table_gb_1) do
      local cand = Candidate("help", seg.start, seg._end, v[2], " " .. v[1])
      -- cand.preedit = input .. "\t※ 輸入【項目】每字第一個注音，調出相關符號。"
      yield(cand)
    end
  end

  -- if input:find("^``$") then
  -- if check_grave2 then
  if input == "``" then
    for k, v in ipairs(env.table_gb_2) do
      local cand = Candidate("help", seg.start, seg._end, v[2], " " .. v[1])
      -- cand.preedit = input .. "\t※ 輸入【項目】每字第一個注音，調出相關符號。"
      -- cand.preedit = input .. "\t《emoji集》▶"
      yield(cand)
    end
  end

end

-- return instruction_grave_bpmf
return {init = init, func = translate}