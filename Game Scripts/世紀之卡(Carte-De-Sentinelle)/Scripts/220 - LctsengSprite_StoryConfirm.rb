#encoding:utf-8
#==============================================================================
# ■ Lctseng::Sprite_StoryConfirm
#------------------------------------------------------------------------------
#     選單用的切換式按鈕
#==============================================================================
module Lctseng
class Sprite_StoryConfirm < Sprite_SingleButton
  #--------------------------------------------------------------------------
  # ● 加入設定模組
  #--------------------------------------------------------------------------
  include SpriteSlider
  include SpriteFader
  #--------------------------------------------------------------------------
  # ● 初始化對象
  #--------------------------------------------------------------------------
  def initialize(viewport)
    super([536,365],'storyline_select',viewport)
    self.opacity = 0
    fader_init
  end
  #--------------------------------------------------------------------------
  # ● 更新
  #--------------------------------------------------------------------------
  def update
    super
    fader_update
  end
  #--------------------------------------------------------------------------
  # ● 顯示
  #--------------------------------------------------------------------------
  def show
    super
    self.opacity = 0
    fader_set_fade(255,20)
  end
end
end
