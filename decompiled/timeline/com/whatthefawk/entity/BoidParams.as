package com.whatthefawk.entity
{
   import com.whatthefawk.ai.FSM.StateMachineParams;
   
   public class BoidParams extends MovingEntityParams
   {
      
      public var stateMachineParams:StateMachineParams = new StateMachineParams();
      
      public function BoidParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

