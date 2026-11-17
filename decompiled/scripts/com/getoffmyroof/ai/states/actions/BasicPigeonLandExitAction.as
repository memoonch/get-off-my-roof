package com.getoffmyroof.ai.states.actions
{
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.ai.steering.behaviors.Arrive;
   
   public class BasicPigeonLandExitAction extends AAction implements IAction
   {
      
      public function BasicPigeonLandExitAction()
      {
         super();
      }
      
      override public function execute(param1:*) : void
      {
         param1.steering.removeBehavior(Arrive);
      }
   }
}

