package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   
   public class BossRockyPigeonPooAttackAction extends AAction implements IAction
   {
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_pigeon:Pigeon;
      
      public function BossRockyPigeonPooAttackAction()
      {
         super();
         this.m_tickRegulator = new TickRegulator();
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTimeRateTick);
      }
      
      private function onTimeRateTick(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = Math.random() * 100;
         if(_loc2_ > 50)
         {
            _loc3_ = Math.random() * this.m_pigeon.weaponSystem.numWeapons + 1;
            if(this.m_pigeon.isFlying)
            {
               _loc3_ = 3;
            }
            this.m_pigeon.weaponSystem.switchCurrentWeapon(_loc3_);
         }
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

