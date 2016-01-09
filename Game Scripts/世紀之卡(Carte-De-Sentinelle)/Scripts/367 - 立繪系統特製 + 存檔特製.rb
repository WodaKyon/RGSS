#encoding:utf-8
#==============================================================================
# ■ Window_Message
#------------------------------------------------------------------------------
# 　顯示文字信息的窗口。
#==============================================================================

class Window_Message < Window_Base
  #--------------------------------------------------------------------------
  # ● 換行文字的處理 【修改定義】
  #--------------------------------------------------------------------------
  def process_new_line(text, pos)
    @line_show_fast = false
    pos[:x] = pos[:new_x]
    pos[:y] += pos[:height]
    if !@first_line_process
      @first_line_process = true
      change_color(normal_color)
      pos[:y] += 10
    end
    pos[:height] = calc_line_height(text)
    if need_new_page?(text, pos)
      input_pause
      new_page(text, pos)
    end
  end
end



#encoding:utf-8
#==============================================================================
# ■ Lctseng::Sprite_LeftStand
#------------------------------------------------------------------------------
#     左方立繪精靈
#==============================================================================
module Lctseng
class Sprite_LeftStand < Sprite_Stand
  #--------------------------------------------------------------------------
  # ● 已飛入位置調整
  #--------------------------------------------------------------------------
  def slide_in_pos_adjust(pos)
    return super
    # 限制
    if pos[0] + self.width > 480
      pos[0] = 480 - self.width
    end
    pos
  end
end
end

#encoding:utf-8
#==============================================================================
# ■ Lctseng::Sprite_RightStand
#------------------------------------------------------------------------------
#     右方立繪精靈
#==============================================================================
module Lctseng
class Sprite_RightStand < Sprite_Stand
  #--------------------------------------------------------------------------
  # ● 已飛入位置調整
  #--------------------------------------------------------------------------
  def slide_in_pos_adjust(pos)
    # 限制不過半
    if pos[0] < 320
      pos[0] = 320
    end
    pos
  end
end
end




#encoding:utf-8
#==============================================================================
# ■ Scene_Map
#------------------------------------------------------------------------------
# 　游戲中所有 Scene 類（場景類）的父類
#==============================================================================

class Scene_Map
  #--------------------------------------------------------------------------
  # ● 重新定義
  #--------------------------------------------------------------------------
  unless $@
    alias lctseng_mini_menu_start start
    alias lctseng_mini_menu_update_basic update_basic
  end
  #--------------------------------------------------------------------------
  # ● 開始處理 【重新定義】
  #--------------------------------------------------------------------------
  def start
    lctseng_mini_menu_start
    create_mini_menu_viewport
    create_mini_menu_spriteset
  end
  #--------------------------------------------------------------------------
  # ● 產生小選單顯示端口
  #--------------------------------------------------------------------------
  def create_mini_menu_viewport
    @viewport_mini_menu = Viewport.new
    @viewport_mini_menu.z = 100
  end
  #--------------------------------------------------------------------------
  # ● 產生小選單精靈
  #--------------------------------------------------------------------------
  def create_mini_menu_spriteset
    @mini_menu = Lctseng::Spriteset_MiniMenu.new(@viewport_mini_menu)
  end
  #--------------------------------------------------------------------------
  # ● 更新畫面（基礎）【重新定義】
  #--------------------------------------------------------------------------
  def update_basic
    lctseng_mini_menu_update_basic
    update_mini_menu_spriteset
  end
  #--------------------------------------------------------------------------
  # ● 更新小選單精靈
  #--------------------------------------------------------------------------
  def update_mini_menu_spriteset
    @mini_menu.update
  end
  #--------------------------------------------------------------------------
  # ● 釋放小選單精靈
  #--------------------------------------------------------------------------
  def dispose_mini_menu_spriteset
    @mini_menu.dispose
  end
  #--------------------------------------------------------------------------
  # ● 釋放小選單顯示端口
  #--------------------------------------------------------------------------
  def dispose_mini_menu_viewport
    @viewport_mini_menu.dispose
  end
  #--------------------------------------------------------------------------
  # ● 結束處理【重新定義】
  #--------------------------------------------------------------------------
  def terminate
    dispose_mini_menu_spriteset
    DataManager.snapshot_for_save
    stand_terminate
    lctseng_stand_terminate
    dispose_stand_spriteset
    dispose_mini_menu_viewport
  end
  #--------------------------------------------------------------------------
  # ● 立繪結束處理
  #--------------------------------------------------------------------------
  def stand_terminate(keep = true)
    @stand_spriteset.terminate(keep)
    while @stand_spriteset.terminating?
      @stand_spriteset.terminate_countdown
      puts "結束前處理"
      @stand_spriteset.update
      Graphics.update
    end
  end


end
