package com.getoffmyroof.ai.states
{
   import com.whatthefawk.ai.FSM.AState;
   
   public class BasicPigeonDieState extends AState
   {
      
      public function BasicPigeonDieState()
      {
         super();
      }
      
      override public function initialize() : void
      {
         addEnterAction(agent.state.getAction("PigeonDieEnter"));
      }
   }
}

