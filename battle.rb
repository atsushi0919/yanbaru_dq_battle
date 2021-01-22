class Battle
  MESSAGE_SPEED = 0.5
  MESSAGE_LINE = "*" + "=*" * 14

  def initialize(battle_members)
    # バトルメンバー
    @battle_members = battle_members
    # 仲間の情報: リーダー名, 人数
    @allies_leader = battle_members.find { |member| member.ally }.name
    @allies_count = battle_members.count { |member| member.ally }
    # 敵の情報: リーダー名, 人数
    @enemies_leader = battle_members.find { |member| !member.ally }.name
    @enemies_count = battle_members.count { |member| !member.ally }
  end

  # バトルメンバーのステータスを表示
  def show_members_hp
    puts MESSAGE_LINE
    (get_allies + get_enemies).each do |member|
      puts "【#{member.name}】HP: #{member.hp}"
    end
    puts MESSAGE_LINE
  end

  private

  # 仲間リストを返す
  def get_allies
    @battle_members.select { |member| member.ally }
  end

  # 敵リストを返す
  def get_enemies
    @battle_members.select { |member| !member.ally }
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
