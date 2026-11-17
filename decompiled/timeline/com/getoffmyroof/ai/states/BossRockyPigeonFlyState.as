package com.getoffmyroof.ai.states
{
   import com.whatthefawk.ai.FSM.AState;
   import com.whatthefawk.ai.FSM.ICondition;
   import com.whatthefawk.ai.FSM.Transition;
   import com.whatthefawk.ai.FSM.conditions.AndCondition;
   
   public class BossRockyPigeonFlyState extends AState
   {
      
      public function BossRockyPigeonFlyState()
      {
         super();
      }
      
      override public function initialize() : void
      {
         addEnterAction(agent.state.getAction("PigeonFlyEnter"));
         addExitAction(agent.state.getAction("PigeonFlyExit"));
         addAction(agent.state.getAction("PigeonFly"));
         addAction(agent.state.getAction("PigeonFlyAttack"));
         addAction(agent.state.getAction("PigeonAvoidGround"));
         addAction(agent.state.getAction("PigeonFlyAvoidTarget"));
         addAction(agent.state.getAction("PigeonAvoidProjectiles"));
         var _loc1_:ICondition = new AndCondition(agent.state.getCondition("PigeonFlyTimeUp"),agent.state.getCondition("Chance",{"chance":agent.landChance}));
         addTransition(new Transition(agent.state.getState("PigeonLand"),_loc1_));
      }
   }
}

