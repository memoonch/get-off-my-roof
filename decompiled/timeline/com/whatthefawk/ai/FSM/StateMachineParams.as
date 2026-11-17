package com.whatthefawk.ai.FSM
{
   import com.whatthefawk.ai.FSM.conditions.*;
   import com.whatthefawk.utils.Params;
   import flash.utils.Dictionary;
   
   public class StateMachineParams extends Params
   {
      
      public var states:Dictionary;
      
      public var agent:*;
      
      public var initialGlobalState:Class;
      
      public var initialState:Class;
      
      public var conditions:Dictionary;
      
      public var actions:Dictionary;
      
      public function StateMachineParams(param1:Object = null)
      {
         super();
         this.states = new Dictionary();
         this.actions = new Dictionary();
         this.conditions = new Dictionary();
         this.states["NothingState"] = NothingState;
         this.conditions["Or"] = OrCondition;
         this.conditions["And"] = AndCondition;
         this.conditions["Not"] = NotCondition;
         this.conditions["Chance"] = ChanceCondition;
         this.conditions["Position"] = PositionCondition;
         this.initialState = null;
         this.initialGlobalState = null;
         applyParams(param1);
      }
   }
}

