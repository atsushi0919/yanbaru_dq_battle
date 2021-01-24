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
    enemies = get_team_member(ally = false)
    show_start_message(enemies)

    # 戦闘ループ
    while true
      stop, winner = forward_turn
      break if stop
    end

    # 1対1ならそのまま終了
    return if solo_battle?
    # 1対1でなければ最後にメッセージを表示する
    show_members_hp
    params = { winner: winner,
               allies_leader: @allies_leader,
               allies_count: @allies_count,
               enemies_count: @enemies_count }
    show_party_ending(params)
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
      # targetチームに生存者がいないならtrueと勝者のallyを返す
      alive_member = get_team_member(target.ally, only_alive = true)
      return [true, attacker.ally] if alive_member.empty?
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
      status = trim_status_info(member)
      status = red_string(status) unless alive?(member)
      puts status
    end
    puts PARTITION[1] unless solo_battle?
    enemies.each do |enemy|
      puts trim_status_info(enemy)
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
  def alive?(character)
    character.hp > 0 ? true : false
  end

  # メンバーリストを返す
  # ally: 味方or敵, only_alive: 全員or生存者
  def get_team_member(ally, only_alive = false)
    if only_alive
      @battle_members.select { |member| member.ally == ally && alive?(member) }
    else
      @battle_members.select { |member| member.ally == ally }
    end
  end

  # ステータス情報の表示を整える
  def trim_status_info(character)
    "【#{character.name}】".ljust(9, "　") + "HP:" + "#{character.hp}".rjust(3, " ")
  end
end
