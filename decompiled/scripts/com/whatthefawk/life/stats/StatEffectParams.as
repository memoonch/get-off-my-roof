package com.whatthefawk.life.stats
{
   import com.whatthefawk.utils.Params;
   
   public class StatEffectParams extends Params
   {
      
      public var maxStack:int = 100;
      
      public var lifeTime:int = -1;
      
      public var name:String;
      
      public var tickRate:int = 1000;
      
      public var senderID:String;
      
      public var tags:Array = [];
      
      public var id:String;
      
      public function StatEffectParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

