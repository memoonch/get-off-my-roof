package com.getoffmyroof.ai.states.conditions
{
   import com.whatthefawk.ai.FSM.ACondition;
   import com.whatthefawk.ai.FSM.ICondition;
   
   public class BelowFallLineCondition extends ACondition implements ICondition
   {
      
      private var m_fallLine:int;
      
      public function BelowFallLineCondition(param1:int = 200)
      {
         super();
         this.m_fallLine = param1;
      }
      
      override public function test(param1:*) : Boolean
      {
         if(param1.currentPos.y >= this.m_fallLine)
         {
            return true;
         }
         return false;
      }
      
      public function set fallLine(param1:int) : void
      {
         this.m_fallLine = param1;
      }
   }
}

