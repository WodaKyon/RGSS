#encoding:utf-8
#==============================================================================
# ■ CardBattle::Game_EnemyCardSet
#------------------------------------------------------------------------------
# 　敵人的卡牌組
#==============================================================================

module CardBattle
class Game_EnemyCardSet < Game_CardSet
  #--------------------------------------------------------------------------
  # ● 初始化對象
  #--------------------------------------------------------------------------
  def initialize
    super
  end
  #--------------------------------------------------------------------------
  # ● 清除所有資料
  #--------------------------------------------------------------------------
  def clear_all_data
    super
    @enemy_id = 0
  end
  #--------------------------------------------------------------------------
  # ● 戰鬥設置
  #--------------------------------------------------------------------------
  def battle_setup(id)
    super
    @max_hp = @hp = self.battler.hp
    setup_default_card_set
    set_card_object
  end
  #--------------------------------------------------------------------------
  # ● 設置預設卡組
  #--------------------------------------------------------------------------
  def setup_default_card_set
    @card_hash = CardInfo.init_enemy_card_hash(self.battler_id)
  end
  #--------------------------------------------------------------------------
  # ● 是否是玩家
  #--------------------------------------------------------------------------
  def player?
    false
  end
  #--------------------------------------------------------------------------
  # ● 是否是敵人
  #--------------------------------------------------------------------------
  def enemy?
    true
  end
  #--------------------------------------------------------------------------
  # ● 取得戰鬥者
  #--------------------------------------------------------------------------
  def battler
    $data_enemies[@battler_id]
  end
  #--------------------------------------------------------------------------
  # ● 設置戰鬥者ID，此外會同時設定戰鬥屬性
  #--------------------------------------------------------------------------
  def set_battler_id(val)
    super
    case @battler_id
    when 4,7,11,16,18,23,24,26,27,14
      @battler_type = :attack
    when 1,6,8,9,17,19,21,25,28,13
      @battler_type = :speed
    when 10,12,15,20,22,29,30
      @battler_type = :magic
    else 
      @battler_type = [:magic,:attack,:speed].sample
    end
  end
  #--------------------------------------------------------------------------
  # ● 設置卡牌組實體，產生隨機的卡牌組物件清單
  #      戰鬥開始前必須要呼叫，產生可用的卡
  #--------------------------------------------------------------------------
  def set_card_object
    super
    puts "敵人卡組設定完成"
    print_card_set
  end
  #--------------------------------------------------------------------------
  # ● 執行補充卡牌的副作用
  #--------------------------------------------------------------------------
  def perform_refill_effect
    super
    # 損失當前生命的50%，最多失去60點，不致死
    #val_cur = (@hp * 0.5).round
    #val_max = 60
    #val = [val_cur,val_max].min
    #if val >= @hp
      #val = @hp - 1
    #end
    #lose_hp(val)
  end

  #--------------------------------------------------------------------------
  # ● 取得戰鬥計數器
  #--------------------------------------------------------------------------
  def get_battler_counter
    -1 # 沒數值
  end

  #--------------------------------------------------------------------------
  # ● 數值精靈的位置
  #--------------------------------------------------------------------------
  def number_sprite_pos
    [ENEMY_HP_NUMBER_POS_X,ENEMY_HP_NUMBER_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 框架精靈檔名
  #--------------------------------------------------------------------------
  def frame_filename
    "battlet_chara_Eframe"
  end
  #--------------------------------------------------------------------------
  # ● 框架精靈位置
  #--------------------------------------------------------------------------
  def frame_pos
    [ENEMY_BATTLE_FRAME_POS_X,ENEMY_BATTLE_FRAME_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 模式精靈檔名列表
  #--------------------------------------------------------------------------
  def mode_filename_list
    ['battlet_chara_Eatk','battlet_chara_Edef']
  end
  #--------------------------------------------------------------------------
  # ● 模式精靈位置
  #--------------------------------------------------------------------------
  def mode_pos
    [ENEMY_BATTLE_MODE_POS_X,ENEMY_BATTLE_MODE_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 總和精靈的位置
  #--------------------------------------------------------------------------
  def sum_sprite_pos
    [ENEMY_SUM_NUMBER_POS_X,ENEMY_SUM_NUMBER_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 肖像精靈的位置
  #--------------------------------------------------------------------------
  def portrait_sprite_pos
    [ENEMY_BATTLE_PORTRAIT_POS_X,ENEMY_BATTLE_PORTRAIT_POS_Y]
  end
  #--------------------------------------------------------------------------
  # ● 計數器精靈位置
  #--------------------------------------------------------------------------
  def counter_sprite_pos
    ENEMY_COUNTER_BALL_POS
  end
  

end
end