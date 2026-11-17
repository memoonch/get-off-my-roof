package com.whatthefawk.collision.bounds
{
   import com.whatthefawk.utils.Params;
   
   public class BoundsBehaviorParams extends Params
   {
      
      public var checkBottom:Boolean = true;
      
      public var checkRight:Boolean = true;
      
      public var checkTop:Boolean = true;
      
      public var checkLeft:Boolean = true;
      
      public function BoundsBehaviorParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

