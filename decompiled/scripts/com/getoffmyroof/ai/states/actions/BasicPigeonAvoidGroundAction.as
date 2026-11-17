package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   
   public class BasicPigeonAvoidGroundAction extends AAction implements IAction
   {
      
      private static const AVOID_FORCE:Vector2D = new Vector2D(0,-150);
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_agent:Pigeon;
      
      public function BasicPigeonAvoidGroundAction()
      {
         super();
         this.m_tickRegulator = new TickRegulator(100);
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTimeRateTick);
      }
      
      private function onTimeRateTick(param1:Event) : void
      {
         this.avoidGround();
      }
      
      private function avoidGround() : void
      {
         if(this.m_agent.currentPos.y >= this.m_agent.avoidGroundDistance)
         {
            this.m_agent.applyForce(AVOID_FORCE);
         }
      }
      
      override public function execute(param1:*) : void
      {
         this.m_agent = param1 as Pigeon;
         this.m_tickRegulator.update();
      }
   }
}

