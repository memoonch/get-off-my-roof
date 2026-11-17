package com.getoffmyroof.ui
{
   import com.whatthefawk.utils.Params;
   
   public class GameLevelButtonParams extends Params
   {
      
      public var id:String;
      
      public var debugLevel:Boolean = false;
      
      public var isLocked:Boolean = false;
      
      public var medal:int = 0;
      
      public var title:String = "- No Title -";
      
      public var iconFrame:int = 0;
      
      public var levelID:String;
      
      public function GameLevelButtonParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

