package com.getoffmyroof.ui
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class AchievementPopup extends Sprite
   {
      
      public var text:TextField;
      
      public function AchievementPopup()
      {
         super();
      }
      
      public function dispose() : void
      {
         parent.removeChild(this);
      }
   }
}

