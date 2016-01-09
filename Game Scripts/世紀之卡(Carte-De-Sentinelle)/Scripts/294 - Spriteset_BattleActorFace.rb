#encoding:utf-8
#==============================================================================
# ■ CardBattle::Spriteset_BattleActorFace
#------------------------------------------------------------------------------
#   顯示角色肖像的精靈組，包含了攻擊與防禦模式
#==============================================================================
module CardBattle
class Spriteset_BattleActorFace
  #--------------------------------------------------------------------------
  # ● 初始化對象
  #--------------------------------------------------------------------------
  def initialize(card_set,viewport)
    @viewport = viewport
    @card_set = card_set # 設定所屬卡組
    create_sprites
  end
  #--------------------------------------------------------------------------
  # ● 產生精靈
  #--------------------------------------------------------------------------
  def create_sprites
    # 框架精靈
    @frame = Sprite.new(@viewport)
    @frame.bitmap = Cache.battle(@card_set.frame_filename)
    @frame.set_pos(@card_set.frame_pos)
    @frame.z = 10
    # 模式精靈
    @mode = Sprite_BattleModeCover.new(@card_set,@viewport)
    # 肖像
    @portrait = Sprite_BattlePortrait.new(@card_set,@viewport)
  end
  #--------------------------------------------------------------------------
  # ● 釋放
  #--------------------------------------------------------------------------
  def dispose
    @mode.dispose
    @frame.dispose
    @portrait.dispose
  end
  #--------------------------------------------------------------------------
  # ● 更新
  #--------------------------------------------------------------------------
  def update
    @mode.update
  end
  #--------------------------------------------------------------------------
  # ● 顯示戰鬥模式
  #--------------------------------------------------------------------------
  def show_battle_mode
    @mode.show
  end
  #--------------------------------------------------------------------------
  # ● 隱藏戰鬥模式
  #--------------------------------------------------------------------------
  def hide_battle_mode
    @mode.hide
  end
end
end