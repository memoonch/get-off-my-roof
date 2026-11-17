package com.whatthefawk.ai.FSM.conditions
{
   import com.whatthefawk.ai.FSM.ACondition;
   import com.whatthefawk.ai.FSM.ICondition;
   
   public class OrCondition extends ACondition implements ICondition
   {
      
      private var m_conditionA:ICondition;
      
      private var m_conditionB:ICondition;
      
      public function OrCondition(param1:ICondition = null, param2:ICondition = null)
      {
         super();
         this.m_conditionA = param1;
         this.m_conditionB = param2;
      }
      
      override public function test(param1:*) : Boolean
      {
         if(!this.m_conditionA || !this.m_conditionB)
         {
            return false;
         }
         return this.m_conditionA.test(param1) || this.m_conditionB.test(param1);
      }
   }
}

