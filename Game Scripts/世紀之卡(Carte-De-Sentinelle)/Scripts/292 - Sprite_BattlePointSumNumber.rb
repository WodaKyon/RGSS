#encoding:utf-8
#==============================================================================
# ■ CardBattle::Sprite_BattlePointSumNumber
#------------------------------------------------------------------------------
# 　顯示卡片總和數字的精靈
#==============================================================================
module CardBattle
class Sprite_BattlePointSumNumber < Sprite_Base
  #--------------------------------------------------------------------------
  # ● 加入淡入淡出模組
  #--------------------------------------------------------------------------
  include SpriteDrawer
  include SpriteFader
  #--------------------------------------------------------------------------
  # ● 初始化對象
  #--------------------------------------------------------------------------
  def initialize(viewport)
    super(viewport)
    self.bitmap = Bitmap.new(460,60)
    fader_init
  end
  #--------------------------------------------------------------------------
  # ● 繪製數字
  # 參數：戰鬥模式、技能資訊、最終數值
  #--------------------------------------------------------------------------
  def draw_number(mode,skill,point)
    self.bitmap.clear
    case mode
    when :attack
      if skill[:enable]
        self.bitmap.font = SKILL_SUM_FONT
      else
        self.bitmap.font = ATTACK_SUM_FONT
      end
    when :defend
      self.bitmap.font = DEFEND_SUM_FONT
    end
    draw_text(self.bitmap.rect,point,1)
  end
  #--------------------------------------------------------------------------
  # ● 顯示
  #--------------------------------------------------------------------------
  def show
    self.opacity = 255
    start_animation_id(SUM_SHOW_ANIMATION_ID)
  end
  #--------------------------------------------------------------------------
  # ● 隱藏
  #--------------------------------------------------------------------------
  def hide
    fader_set_fade(0,SUM_HIDE_TIME)
    start_animation_id(SUM_HIDE_ANIMATION_ID)
  end
  #--------------------------------------------------------------------------
  # ● 釋放
  #--------------------------------------------------------------------------
  def dispose
    self.bitmap.dispose
    super
  end
  #--------------------------------------------------------------------------
  # ● 更新
  #--------------------------------------------------------------------------
  def update
    super
    fader_update
  end
  #--------------------------------------------------------------------------
  # ● 是否效果中？
  #--------------------------------------------------------------------------
  def effect?
    fader_fading? || animation?
  end
end
end
