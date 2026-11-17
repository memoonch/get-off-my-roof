package com.whatthefawk.ai.FSM
{
   import com.whatthefawk.utils.ADynamicObject;
   
   public class AAction extends ADynamicObject
   {
      
      public function AAction()
      {
         super();
      }
      
      public function execute(param1:*) : void
      {
         throw new Error("Abstract function must be overridden.");
      }
   }
}

