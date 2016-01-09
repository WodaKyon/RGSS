#encoding:utf-8
#==============================================================================
# ■ CardBattle::Scene_BattleWin
#------------------------------------------------------------------------------
# 　戰鬥勝利場景
#==============================================================================

module CardBattle
class Scene_BattleWin < Scene_Base
  #--------------------------------------------------------------------------
  # ● 獲取漸變速度
  #--------------------------------------------------------------------------
  def transition_speed
    return 30
  end
  #--------------------------------------------------------------------------
  # ● 開始處理
  #--------------------------------------------------------------------------
  def start
    super
    $game_system.battle_only = false
    RPG::BGM.stop
    RPG::ME.new('Fanfare1').play
    @wait_time = WIN_LEAST_WAIT_TIME
    @spriteset = Spriteset_BattleWin.new
  end
  #--------------------------------------------------------------------------
  # ● 結束處理
  #--------------------------------------------------------------------------
  def terminate
    super
    @spriteset.dispose
  end
  #--------------------------------------------------------------------------
  # ● 更新畫面(基礎)
  #--------------------------------------------------------------------------
  def update_basic
    super
    @spriteset.update
    update_input
  end
  #--------------------------------------------------------------------------
  # ● 更新指令輸入
  #--------------------------------------------------------------------------
  def update_input
    # 是否有被要求凍結等待
    if @spriteset.freeze_wait?
      puts "凍結等待中"
      return
    end
    # 至少等待一段時間
    if @wait_time > 0
      @wait_time -= 1
      return
    end
    # 檢測點選
    if Input.trigger?(:C) || Input.trigger?(:B) 
      Sound.play_ok
      SceneManager.goto(Scene_Map)
    end
  end

end
end
