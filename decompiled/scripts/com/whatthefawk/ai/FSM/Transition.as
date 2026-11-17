package com.whatthefawk.ai.FSM
{
   public class Transition
   {
      
      private var m_action:IAction;
      
      private var m_condition:ICondition;
      
      private var m_targetState:AState;
      
      public function Transition(param1:AState, param2:ICondition, param3:IAction = null)
      {
         super();
         this.m_action = param3;
         this.m_condition = param2;
         this.m_targetState = param1;
      }
      
      public function get action() : IAction
      {
         return this.m_action;
      }
      
      public function get targetState() : AState
      {
         return this.m_targetState;
      }
      
      public function isTriggered(param1:*) : Boolean
      {
         return this.m_condition.test(param1);
      }
      
      public function dispose() : void
      {
         this.m_action = null;
         this.m_condition = null;
         this.m_targetState = null;
      }
   }
}

