#encoding:utf-8
#==============================================================================
# ■ Lctseng::Scene_Credit
#------------------------------------------------------------------------------
# 　標題製作人員畫面
#==============================================================================

module Lctseng
class Scene_Credit < Scene_Base
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
    @spriteset = Lctseng::Spriteset_Credit.new
    @spriteset.command_method = method(:command_caller)
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
      return_scene
    end
  end
  

end
end