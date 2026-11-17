package com.whatthefawk.utils
{
   import flash.display.Sprite;
   
   public class SpriteUtil
   {
      
      public function SpriteUtil()
      {
         super();
      }
      
      public static function fitSpriteInSprite(param1:Sprite, param2:Sprite, param3:int = 0) : *
      {
         var _loc4_:Number = param1.width - param3;
         var _loc5_:Number = param1.height - param3;
         var _loc6_:Number = _loc4_ / param2.width;
         var _loc7_:Number = _loc5_ / param2.height;
         param2.width *= _loc6_;
         param2.height *= _loc7_;
         param2.x = param1.width / 2 - param2.width / 2;
         param2.y = param1.height / 2 - param2.height / 2;
         param1.addChild(param2);
      }
      
      public static function resizeSprite(param1:Sprite, param2:Number, param3:Number, param4:int) : void
      {
         var _loc5_:Number = param2 - param4;
         var _loc6_:Number = param3 - param4;
         var _loc7_:Number = _loc5_ / param1.width;
         var _loc8_:Number = _loc6_ / param1.height;
         param1.width *= _loc7_;
         param1.height *= _loc8_;
         param1.x = _loc5_ / 2 - param1.width / 2;
         param1.y = _loc6_ / 2 - param1.height / 2;
      }
      
      public static function removeAllChildren(param1:Sprite) : void
      {
         while(param1.numChildren)
         {
            param1.removeChildAt(0);
         }
      }
   }
}

