require "./brave"
require "./monster"
require "./battle"

# キャラデータ
MONSTER_LIST = [{ name: "メタルスライム", hp: 2, offense: 64, defense: 999 },
                { name: "アークデーモン", hp: 210, offense: 140, defense: 80 },
                { name: "りゅうおう", hp: 230, offense: 170, defense: 130 },
                { name: "シドー", hp: 240, offense: 150, defense: 220 },
                { name: "ゾーマ", hp: 250, offense: 175, defense: 245 }]
BRAVE_PARAMS = { name: "トンヌラ", hp: 238, offense: 173, defense: 188 }

# 対戦表を生成
battle_table = { player: Brave.new(BRAVE_PARAMS),
                 monster: Monster.new(MONSTER_LIST.sample) }

# バトル開始 
battle = Battle.new(battle_table)
battle.start
