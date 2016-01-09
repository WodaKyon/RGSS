#encoding:utf-8
#==============================================================================
# ■ Game_System
#------------------------------------------------------------------------------
# 　處理系統附屬數據的類。保存存檔和菜單的禁止狀態之類的數據。
#   本類的實例請參考 $game_system 。
#==============================================================================

class Game_System
  #--------------------------------------------------------------------------
  # ● 定義實例變量
  #--------------------------------------------------------------------------
  attr_accessor :save_disabled            # 禁用存檔
  attr_accessor :menu_disabled            # 禁用菜單
  attr_accessor :encounter_disabled       # 禁用遇敵
  attr_accessor :formation_disabled       # 禁用整隊
  attr_accessor :battle_count             # 戰斗回數
  attr_reader   :save_count               # 存檔回數
  attr_reader   :version_id               # 游戲版本ID
  #--------------------------------------------------------------------------
  # ● 初始化對象
  #--------------------------------------------------------------------------
  def initialize
    @save_disabled = false
    @menu_disabled = false
    @encounter_disabled = false
    @formation_disabled = false
    @battle_count = 0
    @save_count = 0
    @version_id = 0
    @window_tone = nil
    @battle_bgm = nil
    @battle_end_me = nil
    @saved_bgm = nil
  end
  #--------------------------------------------------------------------------
  # ● 判定是否日語模式
  #--------------------------------------------------------------------------
  def japanese?
    $data_system.japanese
  end
  #--------------------------------------------------------------------------
  # ● 獲取窗口色調
  #--------------------------------------------------------------------------
  def window_tone
    @window_tone || $data_system.window_tone
  end
  #--------------------------------------------------------------------------
  # ● 設置窗口色調
  #--------------------------------------------------------------------------
  def window_tone=(window_tone)
    @window_tone = window_tone
  end
  #--------------------------------------------------------------------------
  # ● 獲取戰斗 BGM
  #--------------------------------------------------------------------------
  def battle_bgm
    @battle_bgm || $data_system.battle_bgm
  end
  #--------------------------------------------------------------------------
  # ● 設置戰斗 BGM
  #--------------------------------------------------------------------------
  def battle_bgm=(battle_bgm)
    @battle_bgm = battle_bgm
  end
  #--------------------------------------------------------------------------
  # ● 獲取戰斗結束 ME
  #--------------------------------------------------------------------------
  def battle_end_me
    @battle_end_me || $data_system.battle_end_me
  end
  #--------------------------------------------------------------------------
  # ● 設置戰斗結束 ME 
  #--------------------------------------------------------------------------
  def battle_end_me=(battle_end_me)
    @battle_end_me = battle_end_me
  end
  #--------------------------------------------------------------------------
  # ● 存檔前的處理
  #--------------------------------------------------------------------------
  def on_before_save
    @save_count += 1
    @version_id = $data_system.version_id
    @frames_on_save = Graphics.frame_count
    @bgm_on_save = RPG::BGM.last
    @bgs_on_save = RPG::BGS.last
  end
  #--------------------------------------------------------------------------
  # ● 讀檔后的處理
  #--------------------------------------------------------------------------
  def on_after_load
    Graphics.frame_count = @frames_on_save
    @bgm_on_save.play
    @bgs_on_save.play
  end
  #--------------------------------------------------------------------------
  # ● 獲取游戲時間的秒數
  #--------------------------------------------------------------------------
  def playtime
    Graphics.frame_count / Graphics.frame_rate
  end
  #--------------------------------------------------------------------------
  # ● 獲取游戲時間的字符串
  #--------------------------------------------------------------------------
  def playtime_s
    hour = playtime / 60 / 60
    min = playtime / 60 % 60
    sec = playtime % 60
    sprintf("%02d:%02d:%02d", hour, min, sec)
  end
  #--------------------------------------------------------------------------
  # ● 保存 BGM 
  #--------------------------------------------------------------------------
  def save_bgm
    @saved_bgm = RPG::BGM.last
  end
  #--------------------------------------------------------------------------
  # ● 重播 BGM 
  #--------------------------------------------------------------------------
  def replay_bgm
    @saved_bgm.replay if @saved_bgm
  end
end
