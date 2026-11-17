package com.whatthefawk.life.stats
{
   import com.whatthefawk.utils.Params;
   
   public class StatParams extends Params
   {
      
      public var baseValue:int = NaN;
      
      public var name:String;
      
      public var maxValue:int = 10;
      
      public var minBaseValue:int = NaN;
      
      public var value:int = 1;
      
      public var id:String;
      
      public var maxBaseValue:int = NaN;
      
      public var minValue:int = 0;
      
      public function StatParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

