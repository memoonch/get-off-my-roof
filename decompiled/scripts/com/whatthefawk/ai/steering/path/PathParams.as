package com.whatthefawk.ai.steering.path
{
   import com.whatthefawk.utils.Params;
   
   public class PathParams extends Params
   {
      
      public var index:int = 0;
      
      public var waypoints:Array = [];
      
      public var type:String = Path.OPEN;
      
      public var id:String;
      
      public function PathParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

