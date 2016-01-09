#encoding:utf-8
#==============================================================================
# ■ Window_EquipItem
#------------------------------------------------------------------------------
# 　裝備畫面中，顯示可替換裝備的窗口。
#==============================================================================

class Window_EquipItem < Window_ItemList
  #--------------------------------------------------------------------------
  # ● 定義實例變量
  #--------------------------------------------------------------------------
  attr_reader   :status_window            # 狀態窗口
  #--------------------------------------------------------------------------
  # ● 初始化對象
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height)
    super
    @actor = nil
    @slot_id = 0
  end
  #--------------------------------------------------------------------------
  # ● 設置角色
  #--------------------------------------------------------------------------
  def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
    self.oy = 0
  end
  #--------------------------------------------------------------------------
  # ● 設置裝備欄 ID 
  #--------------------------------------------------------------------------
  def slot_id=(slot_id)
    return if @slot_id == slot_id
    @slot_id = slot_id
    refresh
    self.oy = 0
  end
  #--------------------------------------------------------------------------
  # ● 查詢使用列表中是否含有此物品
  #--------------------------------------------------------------------------
  def include?(item)
    return true if item == nil
    return false unless item.is_a?(RPG::EquipItem)
    return false if @slot_id < 0
    return false if item.etype_id != @actor.equip_slots[@slot_id]
    return @actor.equippable?(item)
  end
  #--------------------------------------------------------------------------
  # ● 查詢此文件是否可以裝備
  #--------------------------------------------------------------------------
  def enable?(item)
    return true
  end
  #--------------------------------------------------------------------------
  # ● 返回上一個選擇的位置
  #--------------------------------------------------------------------------
  def select_last
  end
  #--------------------------------------------------------------------------
  # ● 設置狀態窗口
  #--------------------------------------------------------------------------
  def status_window=(status_window)
    @status_window = status_window
    call_update_help
  end
  #--------------------------------------------------------------------------
  # ● 更新幫助內容
  #--------------------------------------------------------------------------
  def update_help
    super
    if @actor && @status_window
      temp_actor = Marshal.load(Marshal.dump(@actor))
      temp_actor.force_change_equip(@slot_id, item)
      @status_window.set_temp_actor(temp_actor)
    end
  end
end
