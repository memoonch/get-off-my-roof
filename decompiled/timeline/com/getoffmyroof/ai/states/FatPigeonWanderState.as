package com.getoffmyroof.ai.states
{
   import com.getoffmyroof.ai.states.conditions.BelowFallLineCondition;
   import com.whatthefawk.ai.FSM.AState;
   import com.whatthefawk.ai.FSM.Transition;
   
   public class FatPigeonWanderState extends AState
   {
      
      public function FatPigeonWanderState()
      {
         super();
      }
      
      override public function initialize() : void
      {
         addAction(agent.state.getAction("PigeonWander"));
         addAction(agent.state.getAction("PigeonChaseTarget"));
         addAction(agent.state.getAction("PigeonAttackTarget"));
         addTransition(new Transition(agent.state.getState("PigeonLand"),new BelowFallLineCondition()));
      }
   }
}

