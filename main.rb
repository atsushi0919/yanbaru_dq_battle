require "./brave"
require "./monster"
require "./battle"

# キャラデータ
MONSTER_LIST = [{ name: "メタルスライム", hp: 3, offense: 100, defense: 999 },
                { name: "キメラ", hp: 180, offense: 130, defense: 100 }, 
                { name: "アークデーモン", hp: 210, offense: 140, defense: 80 },
                { name: "りゅうおう", hp: 228, offense: 170, defense: 190 },
                { name: "シドー", hp: 240, offense: 165, defense: 220 },
                { name: "ゾーマ", hp: 250, offense: 175, defense: 245 }]
BRAVE_PARAMS = { name: "トンヌラ", hp: 230, offense: 170, defense: 180 }

# 対戦表を生成
battle_table = { player: Brave.new(BRAVE_PARAMS),
                 monster: Monster.new(MONSTER_LIST[3]) }

# バトル開始 
battle = Battle.new(battle_table)
battle.start
