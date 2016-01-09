#encoding:utf-8
#==============================================================================
# ■ CardBattle::Game_PlayerCardSet
#------------------------------------------------------------------------------
# 　玩家的卡牌組
#==============================================================================

module CardBattle
class Game_PlayerCardSet < Game_CardSet
  #--------------------------------------------------------------------------
  # ● 定義實例變量
  #--------------------------------------------------------------------------
  attr_reader :keep
  #--------------------------------------------------------------------------
  # ● 初始化對象
  #--------------------------------------------------------------------------
  def initialize
    super
    set_init_card
    init_hp
    @keep = false
  end
  #--------------------------------------------------------------------------
  # ● 取得戰鬥者
  #--------------------------------------------------------------------------
  def battler
    $game_actors[@battler_id]
  end
  #--------------------------------------------------------------------------
  # ● 是否是玩家
  #--------------------------------------------------------------------------
  def player?
    true
  end
  #--------------------------------------------------------------------------
  # ● 是否是敵人
  #--------------------------------------------------------------------------
  def enemy?
    false
  end
  #--------------------------------------------------------------------------
  # ● 設置戰鬥者
  #--------------------------------------------------------------------------
  def setup_battler(battler_id)
    super
    @battler_type = self.battler.type
    puts "讀取戰鬥模式：#{@battle_type}"
    set_init_card
    init_hp
  end
  #--------------------------------------------------------------------------
  # ● 設置初始卡組
  #--------------------------------------------------------------------------
  def set_init_card
    @card_hash = $game_actors[@battler_id].card_hash
  end
  #--------------------------------------------------------------------------
  # ● 初始化HP
  #--------------------------------------------------------------------------
  def init_hp
    @hp = self.battler.hp
    @max_hp = self.battler.mhp
  end
  #--------------------------------------------------------------------------
  # ● 設置卡牌組實體，產生隨機的卡牌組物件清單
  #      戰鬥開始前必須要呼叫，產生可用的卡
  #--------------------------------------------------------------------------
  def set_card_object
    super
    puts "玩家卡組設定完成"
    print_card_set
  end
  #--------------------------------------------------------------------------
  # ● 處理升級
  #--------------------------------------------------------------------------
  def process_level_up
    rates = generate_level_up_rates
    self.battler.process_level_up(rates)
  end
  #--------------------------------------------------------------------------
  # ● 設置保留
  #--------------------------------------------------------------------------
  def set_keep(val)
    @keep = val
  end
  #--------------------------------------------------------------------------
  # ● 處理保留
  #--------------------------------------------------------------------------
  def process_keep
    self.battler.set_post_battle_hp(@hp,@keep)
  end
  #--------------------------------------------------------------------------
  # ● 戰鬥後處理
  #--------------------------------------------------------------------------
  def post_battle
    super
    self.battler.post_battle
    $game_party.gain_gold($data_enemies[CardBattle::enemy_id].gold)
  end  
  #--------------------------------------------------------------------------
  # ● 產生升級比率(HP、攻擊、防禦)
  #--------------------------------------------------------------------------
  def generate_level_up_rates
    hp_r = 1.0
    atk_r = 1.0  
    def_r = 0.5  
    if @attack_combo_ok   
      puts "開放攻擊獎勵" 
      atk_r += 0.5
    end
    if @defend_combo_ok 
      puts "開放防禦獎勵"
      def_r += 1.5
    end
    [hp_r,atk_r,def_r]
  end
  #--------------------------------------------------------------------------
  # ● 執行補充卡牌的副作用
  #--------------------------------------------------------------------------
  def perform_refill_effect
    super
    CardBattleManager.player_card_refill_effect
  end
  #--------------------------------------------------------------------------
  # ● 數值精靈的位置
  #--------------------------------------------------------------------------
  def number_sprite_pos
    [PLAYER_HP_NUMBER_POS_X,PLAYER_HP_NUMBER_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 框架精靈檔名
  #--------------------------------------------------------------------------
  def frame_filename
    "battlet_chara_Pframe"
  end
  #--------------------------------------------------------------------------
  # ● 框架精靈位置
  #--------------------------------------------------------------------------
  def frame_pos
    [PLAYER_BATTLE_FRAME_POS_X,PLAYER_BATTLE_FRAME_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 模式精靈檔名列表
  #--------------------------------------------------------------------------
  def mode_filename_list
    ['battlet_chara_Patk','battlet_chara_Pdef']
  end
  #--------------------------------------------------------------------------
  # ● 模式精靈位置
  #--------------------------------------------------------------------------
  def mode_pos
    [PLAYER_BATTLE_MODE_POS_X,PLAYER_BATTLE_MODE_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 總和精靈的位置
  #--------------------------------------------------------------------------
  def sum_sprite_pos
    [PLAYER_SUM_NUMBER_POS_X,PLAYER_SUM_NUMBER_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 肖像精靈的位置
  #--------------------------------------------------------------------------
  def portrait_sprite_pos
    [PLAYER_BATTLE_PORTRAIT_POS_X,PLAYER_BATTLE_PORTRAIT_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 計數器精靈位置
  #--------------------------------------------------------------------------
  def counter_sprite_pos
    PLAYER_COUNTER_BALL_POS
  end
  #--------------------------------------------------------------------------
  # ● 開放攻擊獎勵
  #--------------------------------------------------------------------------
  def open_attack_combo
    @attack_combo_ok = true
  end
  #--------------------------------------------------------------------------
  # ● 取得戰鬥計數器
  #--------------------------------------------------------------------------
  def get_battler_counter
    case self.battler_type
    when :magic
      return @defend_points.reduce(:+)
    when :attack
      if show_attack_last?
        return -1
      else
        return @defend_accu
      end
    else
      return @defend_accu
    end
  end
  #--------------------------------------------------------------------------
  # ● 顯示防禦球？
  #--------------------------------------------------------------------------
  def show_defend_ball?
    true
  end


end
end