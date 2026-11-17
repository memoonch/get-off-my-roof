package com.getoffmyroof.ai.states.actions
{
   import com.getoffmyroof.entity.Pigeon;
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   
   public class PigeonFlyAvoidPlayerAction extends AAction implements IAction
   {
      
      private var m_pigeon:Pigeon;
      
      public function PigeonFlyAvoidPlayerAction()
      {
         super();
      }
      
      override public function execute(param1:*) : void
      {
         this.m_pigeon = param1;
         if(this.m_pigeon.evadeDistance < 1)
         {
            return;
         }
         if(this.m_pigeon.currentPos.distanceTo(this.m_pigeon.target.currentPos) <= this.m_pigeon.evadeDistance)
         {
            this.m_pigeon.stop(0.95);
            this.m_pigeon.applyForce(this.m_pigeon.flyEvadeForce);
         }
      }
   }
}

