#encoding:utf-8
#==============================================================================
# ■ Lctseng::Scene_SelectStory
#------------------------------------------------------------------------------
# 　選角色畫面
#==============================================================================

module Lctseng
class Scene_SelectStory < Scene_Base
  #--------------------------------------------------------------------------
  # ● 開始處理
  #--------------------------------------------------------------------------
  def start
    super
    create_spriteset
  end
  #--------------------------------------------------------------------------
  # ● 產生精靈組
  #--------------------------------------------------------------------------
  def create_spriteset
    @spriteset = Spriteset_SelectStory.new
    @spriteset.command_method = method(:command_caller)
  end
  #--------------------------------------------------------------------------
  # ● 結束前處理
  #--------------------------------------------------------------------------
  def pre_terminate
    super
    Graphics.fadeout(4000 * Graphics.frame_rate / 1000) if !@back
  end
  #--------------------------------------------------------------------------
  # ● 結束處理
  #--------------------------------------------------------------------------
  def terminate
    super
    dispose_spriteset
  end
  #--------------------------------------------------------------------------
  # ● 釋放精靈組
  #--------------------------------------------------------------------------
  def dispose_spriteset
    @spriteset.dispose
  end
  #--------------------------------------------------------------------------
  # ● 更新 (基礎)
  #--------------------------------------------------------------------------
  def update_basic
    super
    @spriteset.update
  end
  #--------------------------------------------------------------------------
  # ● 指令呼叫
  #--------------------------------------------------------------------------
  def command_caller(sym)
    case sym
    when :back
      @back = true
      SceneManager.goto(Scene_Title)
    end
  end
  

end
end