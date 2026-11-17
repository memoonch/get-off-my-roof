package com.whatthefawk.ai.FSM.conditions
{
   import com.whatthefawk.ai.FSM.ACondition;
   import com.whatthefawk.ai.FSM.ICondition;
   import com.whatthefawk.math.Chance;
   
   public class ChanceCondition extends ACondition implements ICondition
   {
      
      private var m_chance:Chance;
      
      public function ChanceCondition(param1:Chance = null)
      {
         super();
         this.m_chance = param1;
      }
      
      override public function test(param1:*) : Boolean
      {
         if(!this.m_chance)
         {
            return false;
         }
         return this.m_chance.test();
      }
      
      public function set chance(param1:Chance) : void
      {
         this.m_chance = param1;
      }
   }
}

