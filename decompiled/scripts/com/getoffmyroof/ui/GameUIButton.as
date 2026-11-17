package com.getoffmyroof.ui
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Bounce;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   
   public class GameUIButton extends GameButton
   {
      
      protected var _defaultScaleX:Number;
      
      protected var _defaultScaleY:Number;
      
      protected var _padding:int = 4;
      
      public function GameUIButton()
      {
         super();
         this._defaultScaleX = scaleX;
         this._defaultScaleY = scaleY;
         var _loc1_:Number = width + this._padding;
         var _loc2_:Number = height + this._padding;
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.beginFill(0);
         _loc3_.graphics.drawRect(-(_loc1_ / 2),-(_loc2_ / 2),_loc1_,_loc2_);
         _loc3_.graphics.endFill();
         _loc3_.alpha = 0;
         addChild(_loc3_);
         var _loc4_:GlowFilter = new GlowFilter(16777215,1,5,5,1);
         var _loc5_:DropShadowFilter = new DropShadowFilter(1,45,0,1,2,2,0.75);
         filters = [_loc5_,_loc4_];
      }
      
      override protected function onRollOut(param1:MouseEvent) : void
      {
         super.onRollOut(param1);
         if(isEnabled)
         {
            TweenMax.to(this,1,{
               "scaleX":this._defaultScaleX,
               "scaleY":this._defaultScaleY,
               "ease":Bounce.easeOut
            });
         }
      }
      
      override protected function onRollOver(param1:MouseEvent) : void
      {
         super.onRollOver(param1);
         if(isEnabled)
         {
            TweenMax.to(this,1,{
               "scaleX":this._defaultScaleX + 0.2,
               "scaleY":this._defaultScaleY + 0.2,
               "ease":Bounce.easeOut
            });
         }
      }
   }
}

