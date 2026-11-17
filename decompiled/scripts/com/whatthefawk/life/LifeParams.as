package com.whatthefawk.life
{
   import com.whatthefawk.life.stats.Stats;
   import com.whatthefawk.utils.Params;
   
   public class LifeParams extends Params
   {
      
      public var initialLife:int = -1;
      
      public var stats:Stats;
      
      public var maxLife:int = 100;
      
      public function LifeParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

