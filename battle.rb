# encoding: utf-8

require "./message"

class Battle
  # メッセージ処理
  include Message

  PARTITION = ["*" + "=*" * 14, "-" * 29]

  def initialize(battle_members)
    # バトルメンバー
    @battle_members = battle_members
    # 友軍情報: リーダー名, 人数
    @allies_leader = battle_members.find { |member| member.ally }.name
    @allies_count = battle_members.count { |member| member.ally }
    # 敵軍情報: リーダー名, 人数
    @enemies_leader = battle_members.find { |member| !member.ally }.name
    @enemies_count = battle_members.count { |member| !member.ally }
  end

  # 1サイクル進める
  def forward_turn
    show_members_hp
    @battle_members.each do |attacker|
      # 攻撃処理
      next unless alive?(attacker)
      target = select_target(attacker)
      damage = attacker.attack(target.defense)
      target.hp = [target.hp - damage, 0].max
      # メッセージ処理
      show_damage(damage, attacker, target)
      # 戦闘終了判定
    end
    show_members_hp
  end

  # 全員のステータスを表示
  def show_members_hp
    allies = get_team_member(ally = true)
    enemies = get_team_member(ally = false)

    puts PARTITION[0]
    allies.each { |member| puts "【#{member.name}】HP: #{member.hp}" }
    puts PARTITION[1] if @allies_count + @enemies_count > 2
    enemies.each { |member| puts "【#{member.name}】HP: #{member.hp}" }
    puts PARTITION[0]
  end

  private

  # 攻撃ターゲットを選択する
  def select_target(attacker)
    get_team_member(!attacker.ally, only_alive = true).sample
  end

  # 生きているか？
  def alive?(member)
    member.hp > 0 ? true : false
  end

  # メンバーリストを返す
  # ally: 友軍or敵軍, only_alive: 全員or生存者
  def get_team_member(ally, only_alive = false)
    if only_alive
      @battle_members.select { |member| member.ally == ally && alive?(member) }
    else
      @battle_members.select { |member| member.ally == ally }
    end
  end

  # 開始メッセージを表示
  def show_start_message
    get_enemies.each do |enemy|
      puts "#{enemy} があらわれた！"
      sleep MESSAGE_SPEED
    end
  end
end

=begin
def ending(winner_idx)
  # 改行
  puts
  # 勇者の勝ち
  if winner_idx == 0
    puts "#{@characters[winner_idx].name} は #{@characters[(winner_idx + 1) % @member].name} をやっつけた！！"
    # 勇者の負け
  else
    puts "\e[31m#{@characters[0].name} は倒されてしまった！\e[0m"
  end
  # 改行
  puts
end

# メッセージ処理
    messages = ["#{@name} の攻撃！", "#{target.name} に"]
    messages[-1] += damage > 0 ? " #{damage} のダメージを与えた！" : "ダメージを与えられなかった！"
    messages.each do |message|
      puts message
      sleep 0.5
=end
