#encoding:utf-8
#==============================================================================
# ■ Game_Switches
#------------------------------------------------------------------------------
# 　處理開關的類。本質上是套了個殼的 Array 。本類的實例請參考 $game_switches 。
#==============================================================================

class Game_Switches
  #--------------------------------------------------------------------------
  # ● 初始化對象
  #--------------------------------------------------------------------------
  def initialize
    @data = []
  end
  #--------------------------------------------------------------------------
  # ● 獲取開關
  #--------------------------------------------------------------------------
  def [](switch_id)
    @data[switch_id] || false
  end
  #--------------------------------------------------------------------------
  # ● 設置開關
  #     value : 開啟 (true) / 關閉 (false)
  #--------------------------------------------------------------------------
  def []=(switch_id, value)
    @data[switch_id] = value
    on_change
  end
  #--------------------------------------------------------------------------
  # ● 設置開關時的處理
  #--------------------------------------------------------------------------
  def on_change
    $game_map.need_refresh = true
  end
end
