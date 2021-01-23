# encoding: utf-8

require "./brave"
require "./monster"
require "./battle"

# キャラデータ
MONSTER_LIST = [{ name: "メタルスライム", hp: 3, offense: 80, defense: 999 },
                { name: "キメラ", hp: 180, offense: 130, defense: 100 },
                { name: "アークデーモン", hp: 210, offense: 140, defense: 120 },
                { name: "りゅうおう", hp: 228, offense: 170, defense: 170 },
                { name: "シドー", hp: 240, offense: 209, defense: 220 },
                { name: "ゾーマ", hp: 255, offense: 255, defense: 255 }]
BRAVE_LIST = [{ name: "もょもと", hp: 223, offense: 165, defense: 175 },
              { name: "トンヌラ", hp: 206, offense: 145, defense: 150 },
              { name: "プリン", hp: 187, offense: 125, defense: 140 }]

def main(brave_count = 1, monster_count = 1)
  # brave_count   設定値: 1-3
  # monster_count 設定値: 1-6

  # 対戦メンバーを生成 (brave_teamから攻撃する)
  brave_team = BRAVE_LIST.first(brave_count).map { |brave| Brave.new(brave) }
  monster_team = MONSTER_LIST.sample(monster_count).map { |monster| Monster.new(monster) }

  # バトル開始
  battle = Battle.new(brave_team + monster_team)
  battle.start
end

main(*ARGV.map(&:to_i))
