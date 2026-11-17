package com.whatthefawk.ai.FSM.conditions
{
   import com.whatthefawk.ai.FSM.ACondition;
   import com.whatthefawk.ai.FSM.ICondition;
   
   public class AndCondition extends ACondition implements ICondition
   {
      
      private var m_conditionA:ICondition;
      
      private var m_conditionB:ICondition;
      
      public function AndCondition(param1:ICondition, param2:ICondition)
      {
         super();
         this.m_conditionA = param1;
         this.m_conditionB = param2;
      }
      
      override public function test(param1:*) : Boolean
      {
         return this.m_conditionA.test(param1) && this.m_conditionB.test(param1);
      }
   }
}

