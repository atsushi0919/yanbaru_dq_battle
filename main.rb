require "./brave"
require "./monster"
require "./battle"
require "byebug"

# キャラデータ
MONSTER_LIST = [{ name: "メタルスライム", hp: 3, offense: 100, defense: 999 },
                { name: "キメラ", hp: 180, offense: 130, defense: 100 },
                { name: "アークデーモン", hp: 210, offense: 140, defense: 80 },
                { name: "りゅうおう", hp: 228, offense: 170, defense: 190 },
                { name: "シドー", hp: 240, offense: 165, defense: 220 },
                { name: "ゾーマ", hp: 250, offense: 175, defense: 245 }]
BRAVE = { name: "トンヌラ", hp: 230, offense: 170, defense: 180 }

# 対戦メンバーを生成 (配列の先頭から順に攻撃する)
battle_members = [Brave.new(BRAVE),
                  Monster.new(MONSTER_LIST.sample),
                  Monster.new(MONSTER_LIST.sample)]

# バトル開始
battle = Battle.new(battle_members)

p battle

#battle.start
