package com.getoffmyroof.ai.states
{
   import com.getoffmyroof.ai.states.conditions.ProjectileInRangeCondition;
   import com.getoffmyroof.entity.RoofGroup;
   import com.whatthefawk.ai.FSM.AState;
   import com.whatthefawk.ai.FSM.Transition;
   import com.whatthefawk.math.Vector2D;
   
   public class BasicPigeonLandState extends AState
   {
      
      private var m_landingPosition:Vector2D;
      
      public function BasicPigeonLandState(param1:Vector2D = null)
      {
         super();
         this.m_landingPosition = param1;
      }
      
      public function set landingPosition(param1:Vector2D) : void
      {
         this.m_landingPosition = param1;
      }
      
      override public function initialize() : void
      {
         var _loc1_:RoofGroup = null;
         if(!this.m_landingPosition)
         {
            _loc1_ = agent.roofGroup;
            this.m_landingPosition = _loc1_.getRandomLandingPosition();
         }
         addEnterAction(agent.state.getAction("PigeonLandEnter",{"landingPosition":this.m_landingPosition}));
         addExitAction(agent.state.getAction("PigeonLandExit"));
         addTransition(new Transition(agent.state.getState("PigeonWander"),agent.state.getCondition("Position",{"position":this.m_landingPosition}),agent.state.getAction("PigeonLand")));
         addTransition(new Transition(agent.state.getState("PigeonFly"),new ProjectileInRangeCondition(),agent.state.getAction("PigeonPanic")));
      }
   }
}

