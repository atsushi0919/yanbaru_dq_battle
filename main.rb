require "./brave"
require "./monster"
require "./battle"

# data
MONSTER_LIST = [{ name: "MS", hp: 2, offense: 80, defense: 999 },
                { name: "AD", hp: 210, offense: 140, defense: 80 },
                { name: "RYU", hp: 230, offense: 170, defense: 130 },
                { name: "SHID", hp: 240, offense: 230, defense: 220 },
                { name: "ZM", hp: 250, offense: 255, defense: 255 }]
BRAVE_PARAMS = { name: "abc", hp: 238, offense: 203, defense: 129 }

# c生成
bt_chars = { pl: Brave.new(BRAVE_PARAMS),
             ms: Monster.new(MONSTER_LIST.sample) }
# bt
bt = Battle.new(bt_chars)
bt.start_battle
