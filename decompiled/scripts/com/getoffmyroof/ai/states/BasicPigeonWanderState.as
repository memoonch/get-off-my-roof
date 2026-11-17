package com.getoffmyroof.ai.states
{
   import com.getoffmyroof.ai.states.conditions.BelowFallLineCondition;
   import com.getoffmyroof.ai.states.conditions.ProjectileInRangeCondition;
   import com.whatthefawk.ai.FSM.AState;
   import com.whatthefawk.ai.FSM.Transition;
   
   public class BasicPigeonWanderState extends AState
   {
      
      public function BasicPigeonWanderState()
      {
         super();
      }
      
      override public function initialize() : void
      {
         addAction(agent.state.getAction("PigeonWander"));
         addAction(agent.state.getAction("PigeonChaseTarget"));
         addAction(agent.state.getAction("PigeonAvoidTarget"));
         addAction(agent.state.getAction("PigeonAttackTarget"));
         addTransition(new Transition(agent.state.getState("PigeonFly"),new ProjectileInRangeCondition(agent.scareDistance),agent.state.getAction("PigeonPanic")));
         addTransition(new Transition(agent.state.getState("PigeonLand"),new BelowFallLineCondition()));
      }
   }
}

