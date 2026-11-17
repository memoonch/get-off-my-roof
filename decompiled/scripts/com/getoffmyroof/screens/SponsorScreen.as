package com.getoffmyroof.screens
{
   import com.getoffmyroof.engine.GameComponents;
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Bounce;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.ScreenManager;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol467")]
   public class SponsorScreen extends AScreen
   {
      
      private var m_nextScreen:String = "MainScreen";
      
      public var background:MovieClip;
      
      public var temp_sponsor_logo:MovieClip;
      
      private var m_screenManager:ScreenManager;
      
      public function SponsorScreen(param1:IScreenItem = null)
      {
         super(param1);
         this.m_screenManager = GameComponents.instance.getScreenManager();
         var _loc2_:MovieClip = this.background;
         var _loc3_:MovieClip = this.temp_sponsor_logo;
         var _loc4_:TimelineMax = new TimelineMax();
         _loc4_.append(TweenMax.from(_loc2_,2,{"alpha":0}));
         _loc4_.append(TweenMax.to(_loc3_,2,{
            "alpha":1,
            "y":height / 2 - _loc3_.height,
            "ease":Bounce.easeOut
         }));
         _loc4_.append(TweenMax.to(_loc3_,2,{
            "delay":2,
            "alpha":0
         }));
         _loc4_.append(TweenMax.delayedCall(2,this.onSponsorComplete));
      }
      
      private function onSponsorComplete() : void
      {
         this.m_screenManager.setScreen(this.m_nextScreen);
      }
      
      override public function dispose() : void
      {
         this.m_screenManager = null;
         super.dispose();
      }
   }
}

