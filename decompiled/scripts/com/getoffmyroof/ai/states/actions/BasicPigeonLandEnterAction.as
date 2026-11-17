package com.getoffmyroof.ai.states.actions
{
   import com.whatthefawk.ai.FSM.AAction;
   import com.whatthefawk.ai.FSM.IAction;
   import com.whatthefawk.ai.steering.behaviors.Arrive;
   import com.whatthefawk.math.Vector2D;
   
   public class BasicPigeonLandEnterAction extends AAction implements IAction
   {
      
      public var landingPosition:Vector2D;
      
      public function BasicPigeonLandEnterAction(param1:Vector2D = null)
      {
         super();
         this.landingPosition = param1;
      }
      
      override public function execute(param1:*) : void
      {
         if(!this.landingPosition)
         {
            return;
         }
         param1.prepareToLand();
         param1.steering.addBehavior(new Arrive(this.landingPosition));
      }
   }
}

