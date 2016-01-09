#encoding:utf-8
#==============================================================================
# ■ Lctseng::Scene_File
#------------------------------------------------------------------------------
# 　存讀檔畫面
#==============================================================================


class Scene_File < Scene_Base
  #--------------------------------------------------------------------------
  # ● 開始處理
  #--------------------------------------------------------------------------
  def start
    super
    create_spriteset
  end
  #--------------------------------------------------------------------------
  # ● 取得精靈組class
  #--------------------------------------------------------------------------
  def spriteset_class
    Lctseng::Spriteset_File
  end
  #--------------------------------------------------------------------------
  # ● 產生精靈組
  #--------------------------------------------------------------------------
  def create_spriteset
    @spriteset = spriteset_class.new
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
  def command_caller(sym,index = -1)
    case sym
    when :back
      return_scene
    when :file
      if index >= 0
        @index = index
        on_savefile_ok
      end
    end
  end
  #--------------------------------------------------------------------------
  # ● 確認檔案
  #--------------------------------------------------------------------------
  def on_savefile_ok
    puts "確認檔案：#{@index}"
  end

end