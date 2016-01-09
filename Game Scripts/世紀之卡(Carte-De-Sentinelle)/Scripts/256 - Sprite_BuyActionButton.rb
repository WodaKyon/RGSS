#encoding:utf-8
#==============================================================================
# ■ Sprite_BuyActionButton
#------------------------------------------------------------------------------
#     購買指令的按鈕
#==============================================================================
module Lctseng
class Sprite_BuyActionButton < Sprite_SingleButton
  #--------------------------------------------------------------------------
  # ● 位圖圖取方法
  #--------------------------------------------------------------------------
  def bitmap_loader
    Cache.method(:buy)
  end
  #--------------------------------------------------------------------------
  # ● 檔名格式：選擇
  #--------------------------------------------------------------------------
  def select_fmt
    in_fmt
  end
end
end
