package com.whatthefawk.ai.FSM.conditions
{
   import com.whatthefawk.ai.FSM.ACondition;
   import com.whatthefawk.ai.FSM.ICondition;
   
   public class NotCondition extends ACondition implements ICondition
   {
      
      private var m_condition:ICondition;
      
      public function NotCondition(param1:ICondition)
      {
         super();
         this.m_condition = param1;
      }
      
      override public function test(param1:*) : Boolean
      {
         if(!this.m_condition)
         {
            return false;
         }
         return !this.m_condition.test(param1);
      }
   }
}

