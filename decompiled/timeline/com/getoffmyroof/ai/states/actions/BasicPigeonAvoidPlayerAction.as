package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.ai.states.BasicPigeonLandState;
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   
   public class BasicPigeonAvoidPlayerAction extends AAction implements IAction
   {
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_agent:Pigeon;
      
      public function BasicPigeonAvoidPlayerAction()
      {
         super();
         this.m_tickRegulator = new TickRegulator(100);
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTimeRateTick);
      }
      
      private function avoidTrapBetweenRoofEdgeAndPlayer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.m_agent.roofEdgePanicChance.test())
         {
            if(this.m_agent.currentPerch)
            {
               _loc1_ = this.m_agent.currentPerch.length.length;
               _loc2_ = this.m_agent.currentPos.distanceTo(this.m_agent.currentPerch.fromPoint);
               _loc3_ = this.m_agent.radius + this.m_agent.roofEdgePanicDistance;
               if(this.m_agent.currentPerch.angle.toDegrees() < 0)
               {
                  if(_loc1_ - _loc2_ < _loc3_)
                  {
                     this.m_agent.state.changeState(new BasicPigeonLandState());
                  }
               }
               else if(_loc2_ < _loc3_)
               {
                  this.m_agent.state.changeState(new BasicPigeonLandState());
               }
            }
         }
      }
      
      private function onTimeRateTick(param1:Event) : void
      {
         this.avoidTarget();
      }
      
      override public function execute(param1:*) : void
      {
         this.m_agent = param1 as Pigeon;
         this.m_tickRegulator.update();
      }
      
      private function avoidTarget() : void
      {
         if(this.m_agent.avoidChance.test())
         {
            if(this.m_agent.target.currentPos.x > this.m_agent.currentPos.x && this.m_agent.target.currentPos.x < this.m_agent.currentPos.x + this.m_agent.avoidDistance)
            {
               this.m_agent.hop(Pigeon.HOP_LEFT);
               this.avoidTrapBetweenRoofEdgeAndPlayer();
            }
            else if(this.m_agent.target.currentPos.x < this.m_agent.currentPos.x && this.m_agent.target.currentPos.x > this.m_agent.currentPos.x - this.m_agent.avoidDistance)
            {
               this.m_agent.hop(Pigeon.HOP_RIGHT);
               this.avoidTrapBetweenRoofEdgeAndPlayer();
            }
         }
         if(this.m_agent.panicChance.test())
         {
            if(this.m_agent.target.currentPos.x < this.m_agent.currentPos.x + this.m_agent.panicDistance && this.m_agent.target.currentPos.x > this.m_agent.currentPos.x - this.m_agent.panicDistance)
            {
               this.m_agent.state.changeState(new BasicPigeonLandState());
            }
         }
      }
   }
}

