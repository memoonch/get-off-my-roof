package com.getoffmyroof.ai.states.conditions
{
   import com.whatthefawk.ai.FSM.ACondition;
   import com.whatthefawk.ai.FSM.ICondition;
   
   public class FlyTimeUpCondition extends ACondition implements ICondition
   {
      
      public function FlyTimeUpCondition()
      {
         super();
      }
      
      override public function test(param1:*) : Boolean
      {
         return param1.isFlyTimeUp ? true : false;
      }
   }
}

