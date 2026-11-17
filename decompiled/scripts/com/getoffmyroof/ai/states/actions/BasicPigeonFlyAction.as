package com.getoffmyroof.ai.states.actions
{
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.ai.steering.behaviors.Evade;
   
   public class BasicPigeonFlyAction extends AAction implements IAction
   {
      
      public function BasicPigeonFlyAction()
      {
         super();
      }
      
      override public function execute(param1:*) : void
      {
         var _loc2_:Evade = param1.steering.getBehavior(Evade);
         if(_loc2_)
         {
            _loc2_.panicDist = param1.evadeDistance;
         }
      }
   }
}

