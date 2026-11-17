package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   
   public class BasicPigeonPooAttackAction extends AAction implements IAction
   {
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_pigeon:Pigeon;
      
      public function BasicPigeonPooAttackAction()
      {
         super();
         this.m_tickRegulator = new TickRegulator();
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTimeRateTick,false,0,true);
      }
      
      private function onTimeRateTick(param1:Event) : void
      {
         if(this.m_pigeon.attackDistance == -1 || this.m_pigeon.target.currentPos.x < this.m_pigeon.currentPos.x + this.m_pigeon.attackDistance && this.m_pigeon.target.currentPos.x > this.m_pigeon.currentPos.x - this.m_pigeon.attackDistance)
         {
            if(this.m_pigeon.attackChance.test())
            {
               this.m_pigeon.attack();
            }
         }
         else if(this.m_pigeon.pooChance.test())
         {
            this.m_pigeon.attack();
         }
      }
      
      override public function execute(param1:*) : void
      {
         this.m_pigeon = param1;
         this.m_tickRegulator.update();
      }
   }
}

