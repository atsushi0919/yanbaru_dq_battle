# encoding: utf-8

require "./message"

class Battle
  # メッセージ処理
  include Message

  PARTITION = ["*" + "=*" * 12, "-" * 25]

  def initialize(battle_members)
    # バトルメンバー
    @battle_members = battle_members
    # 味方情報: リーダー名, 人数
    @allies_leader = battle_members.find { |member| member.ally }.name
    @allies_count = battle_members.count { |member| member.ally }
    # 敵情報: リーダー名（不使用）, 人数
    @enemies_leader = battle_members.find { |member| !member.ally }.name
    @enemies_count = battle_members.count { |member| !member.ally }
  end

  # オートバトル
  def start
    # 開始メッセージ
    show_start_message(get_team_member(ally = false))
    # 戦闘ループ
    while true
      stop = forward_turn
      return if stop
    end
  end

  # 1ターン進める
  def forward_turn
    @battle_members.each do |attacker|
      # 攻撃処理
      next unless alive?(attacker)
      target = select_target(attacker)
      damage = attacker.attack(target.defense)
      target.hp = [target.hp - damage, 0].max
      # メッセージ表示
      show_damage(damage, attacker, target)
      unless alive?(target)
        show_members_hp if solo_battle?
        show_knockdown(attacker, target)
      end
      # 戦闘終了判定
      if get_team_member(target.ally, only_alive = true).empty?
        winner = attacker.ally
        if solo_battle?
          # 1対1ならそのまま終了
          return true
        else
          # 1対1でなければ最後にメッセージを表示する
          show_members_hp
          params = { winner: winner,
                     allies_leader: @allies_leader,
                     allies_count: @allies_count,
                     enemies_count: @enemies_count }
          show_party_ending(params)
          return true
        end
      end
    end
    show_members_hp
    false
  end

  # 全員のステータスを表示
  def show_members_hp
    allies = get_team_member(ally = true)
    enemies = get_team_member(ally = false)

    puts PARTITION[0]
    allies.each do |member|
      status = "【#{member.name}】".ljust(9, "　") + "HP:" + "#{member.hp}".rjust(3, " ")
      status = red_status(status) unless alive?(member)
      puts status
    end
    puts PARTITION[1] if @allies_count + @enemies_count > 2
    enemies.each do |member|
      puts "【#{member.name}】".ljust(9, "　") + "HP:" + "#{member.hp}".rjust(3, " ")
    end
    puts PARTITION[0]
  end

  private

  # 1vs1かを返す
  def solo_battle?
    @battle_members.size == 2
  end

  # 攻撃ターゲットを選択する
  def select_target(attacker)
    get_team_member(!attacker.ally, only_alive = true).sample
  end

  # 生きているかを返す
  def alive?(member)
    member.hp > 0 ? true : false
  end

  # ステータスを赤文字にする
  def red_status(status)
    "\e[31m" + status + "\e[0m"
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
