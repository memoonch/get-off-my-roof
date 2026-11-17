package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   
   public class BasicPigeonChasePlayerAction extends AAction implements IAction
   {
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_agent:Pigeon;
      
      public function BasicPigeonChasePlayerAction()
      {
         super();
         this.m_tickRegulator = new TickRegulator(100);
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTimeRateTick,false,0,true);
      }
      
      private function onTimeRateTick(param1:Event) : void
      {
         this.chaseTarget();
      }
      
      override public function execute(param1:*) : void
      {
         this.m_agent = param1;
         this.m_tickRegulator.update();
      }
      
      private function chaseTarget() : void
      {
         if(this.m_agent.chaseChance.test())
         {
            if(this.m_agent.target.currentPos.x > this.m_agent.currentPos.x)
            {
               this.m_agent.hop(Pigeon.HOP_RIGHT);
            }
            else if(this.m_agent.target.currentPos.x < this.m_agent.currentPos.x)
            {
               this.m_agent.hop(Pigeon.HOP_LEFT);
            }
         }
      }
   }
}

