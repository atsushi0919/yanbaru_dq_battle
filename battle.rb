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
    # 敵軍情報: リーダー名（不使用）, 人数
    @enemies_leader = battle_members.find { |member| !member.ally }.name
    @enemies_count = battle_members.count { |member| !member.ally }
  end

  # 1サイクル進める
  def forward_turn
    # 開始メッセージ
    show_start_message(get_team_member(ally = false))
    @battle_members.each do |attacker|
      # 攻撃処理
      next if !alive?(attacker)
      target = select_target(attacker)
      damage = attacker.attack(target.defense)
      target.hp = [target.hp - damage, 0].max
      # メッセージ表示
      show_damage(damage, attacker, target)
      # 戦闘終了判定
      if get_team_member(target.ally, only_alive = true) == 0
        show_members_hp
        winner = !target.ally
        if @allies_count == 1 && @enemies_count == 1
          return
        else
          params = { winner: winner,
                     allies_leader: @allies_leader,
                     allies_count: @allies_count,
                     enemies_count: @enemies_count }
          show_party_ending(message_params)
          return
        end
      end
    end
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

  # 生きているかを返す
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
end
