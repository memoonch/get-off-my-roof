package com.whatthefawk.ai.FSM
{
   import com.whatthefawk.utils.ADynamicObject;
   
   public class ACondition extends ADynamicObject
   {
      
      public function ACondition()
      {
         super();
      }
      
      public function test(param1:*) : Boolean
      {
         throw new Error("Abstract function must be overridden.");
      }
   }
}

