package com.getoffmyroof.levels
{
   import com.whatthefawk.entity.GameWorld;
   import com.whatthefawk.utils.Params;
   
   public class GameLevelParams extends Params
   {
      
      public var gameWorld:GameWorld;
      
      public var id:String;
      
      public var music:String;
      
      public var name:String;
      
      public var description:String;
      
      public function GameLevelParams(param1:Object = null)
      {
         if(!param1.music || param1.music == undefined)
         {
            param1.music = "BattleMusic";
         }
         super(param1);
      }
   }
}

