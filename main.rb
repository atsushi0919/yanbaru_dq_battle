# encoding: utf-8

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
BRAVE_LIST = [{ name: "もょもと", hp: 230, offense: 170, defense: 180 },
              { name: "トンヌラ", hp: 210, offense: 150, defense: 150 },
              { name: "プリン", hp: 202, offense: 125, defense: 140 }]

# 対戦メンバーを生成 (brave_teamから攻撃する)
brave_count = 3
monster_count = 2
brave_team = BRAVE_LIST.sample(brave_count).map { |brave| Brave.new(brave) }
monster_team = MONSTER_LIST.sample(monster_count).map { |monster| Monster.new(monster) }

# バトル開始
battle = Battle.new(brave_team + monster_team)

battle.forward_turn
#battle.show_members_hp
