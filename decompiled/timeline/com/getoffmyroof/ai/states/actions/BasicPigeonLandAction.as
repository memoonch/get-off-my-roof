package com.getoffmyroof.ai.states.actions
{
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   
   public class BasicPigeonLandAction extends AAction implements IAction
   {
      
      public function BasicPigeonLandAction()
      {
         super();
      }
      
      override public function execute(param1:*) : void
      {
         param1.land();
      }
   }
}

