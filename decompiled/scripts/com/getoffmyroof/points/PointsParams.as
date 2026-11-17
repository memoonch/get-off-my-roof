package com.getoffmyroof.points
{
   import com.whatthefawk.utils.Params;
   
   public class PointsParams extends Params
   {
      
      public var points:int = -1;
      
      public var maxPoints:int = -1;
      
      public var pointLossPerTick:int = 0;
      
      public var pointLossDelay:int = 0;
      
      public var minPoints:int = -1;
      
      public var tickRate:int = 0;
      
      public function PointsParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

