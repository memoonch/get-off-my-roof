package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.entity.Pigeon;
   import com.getoffmyroof.entity.Player;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.utils.TickRegulator;
   import com.whatthefawk.weapons.projectile.Projectile;
   import flash.events.Event;
   
   public class BasicPigeonAvoidProjectilesAction extends AAction implements IAction
   {
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_agent:Pigeon;
      
      public function BasicPigeonAvoidProjectilesAction()
      {
         super();
         this.m_tickRegulator = new TickRegulator(100);
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTick,false,0,true);
      }
      
      private function onTick(param1:Event) : void
      {
         this.avoidProjectiles();
      }
      
      override public function execute(param1:*) : void
      {
         this.m_agent = param1 as Pigeon;
         this.m_tickRegulator.update();
      }
      
      private function avoidProjectiles() : void
      {
         var _loc2_:Projectile = null;
         var _loc3_:Number = NaN;
         var _loc1_:Array = this.m_agent.parent.getChildren(Projectile);
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.shooter is Player)
            {
               _loc3_ = this.m_agent.currentPos.distanceTo(_loc2_.currentPos);
               if(_loc3_ - this.m_agent.radius <= this.m_agent.flyScareDistance)
               {
                  this.m_agent.scare();
               }
            }
         }
      }
   }
}

