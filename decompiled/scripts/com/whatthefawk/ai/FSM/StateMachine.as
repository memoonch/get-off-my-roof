package com.whatthefawk.ai.FSM
{
   import com.whatthefawk.entity.IMessageReceiver;
   import com.whatthefawk.entity.Telegram;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class StateMachine implements IMessageReceiver
   {
      
      private var m_previousState:AState;
      
      private var m_states:Dictionary;
      
      private var m_previousStateID:String;
      
      private var m_currentState:AState;
      
      private var m_actions:Dictionary;
      
      private var m_agent:*;
      
      private var m_previousGlobalStateID:String;
      
      private var m_currentStateID:String;
      
      private var m_conditions:Dictionary;
      
      private var m_globalState:AState;
      
      private var m_previousGlobalState:AState;
      
      private var m_globalStateID:String;
      
      public function StateMachine(param1:*, param2:StateMachineParams)
      {
         super();
         this.m_agent = param1;
         this.m_states = param2.states ? param2.states : new Dictionary();
         this.m_actions = param2.actions ? param2.actions : new Dictionary();
         this.m_conditions = param2.conditions ? param2.conditions : new Dictionary();
         this.changeGlobalState(this.getState("NothingState"));
         this.changeState(this.getState("NothingState"));
      }
      
      public function get states() : Dictionary
      {
         return this.m_states;
      }
      
      public function get previousGlobalStateID() : String
      {
         return this.m_previousGlobalStateID;
      }
      
      public function getConditionClass(param1:String) : Class
      {
         if(!this.m_conditions[param1])
         {
            throw new Error("<StateMachine::getCondition()> Condition " + param1 + " does not exist.");
         }
         return this.m_conditions[param1];
      }
      
      public function get currentState() : AState
      {
         return this.m_currentState;
      }
      
      public function dispose() : void
      {
         this.m_agent = null;
         this.m_states = null;
         this.m_actions = null;
         this.m_conditions = null;
         this.m_globalState = null;
         this.m_currentState = null;
         this.m_previousState = null;
         this.m_previousGlobalState = null;
      }
      
      public function revertToPreviousState() : void
      {
         this.changeState(this.m_previousState);
      }
      
      public function traceStates() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in this.m_states)
         {
         }
      }
      
      public function getActionClass(param1:String) : Class
      {
         if(!this.m_actions[param1])
         {
            throw new Error("<StateMachine::getAction()> Action " + param1 + " does not exist.");
         }
         return this.m_actions[param1];
      }
      
      public function get globalState() : AState
      {
         return this.m_globalState;
      }
      
      public function get previousGlobalState() : AState
      {
         return this.m_previousGlobalState;
      }
      
      public function revertToPreviousGlobalState() : void
      {
         this.changeGlobalState(this.m_previousGlobalState);
      }
      
      public function getAction(param1:String, param2:Object = null) : AAction
      {
         if(!this.m_actions[param1])
         {
            throw new Error("<StateMachine::getAction()> Action " + param1 + " does not exist.");
         }
         var _loc3_:AAction = new this.m_actions[param1]();
         _loc3_.applyParams(param2);
         return _loc3_;
      }
      
      public function handleMessage(param1:Telegram) : Boolean
      {
         if(this.m_currentState.handleMessage(param1))
         {
            return true;
         }
         if(this.m_globalState.handleMessage(param1))
         {
            return true;
         }
         return false;
      }
      
      public function changeState(param1:AState) : void
      {
         if(param1 == this.m_currentState)
         {
            return;
         }
         if(this.m_currentState)
         {
            this.m_previousState = this.m_currentState;
            this.m_currentState.exit();
         }
         this.m_currentState = param1;
         this.m_currentState.setAgent(this.m_agent);
         this.m_currentState.initialize();
         this.m_currentState.enter();
      }
      
      public function get currentStateID() : String
      {
         return this.m_currentStateID;
      }
      
      public function wasInState(param1:Class) : Boolean
      {
         return this.m_previousState is param1;
      }
      
      public function get globalStateID() : String
      {
         return this.m_globalStateID;
      }
      
      public function update() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(this.m_globalState)
         {
            for each(_loc1_ in this.m_globalState.actions)
            {
               _loc1_.execute(this.m_agent);
            }
            for each(_loc2_ in this.m_globalState.transitions)
            {
               if(_loc2_.isTriggered(this.m_agent))
               {
                  if(_loc2_.action)
                  {
                     _loc2_.action.execute(this.m_agent);
                  }
                  this.changeGlobalState(_loc2_.targetState);
               }
            }
         }
         if(this.m_currentState)
         {
            for each(_loc1_ in this.m_currentState.actions)
            {
               _loc1_.execute(this.m_agent);
            }
            for each(_loc2_ in this.m_currentState.transitions)
            {
               if(_loc2_.isTriggered(this.m_agent))
               {
                  if(_loc2_.action)
                  {
                     _loc2_.action.execute(this.m_agent);
                  }
                  this.changeState(_loc2_.targetState);
               }
            }
         }
      }
      
      public function get previousState() : AState
      {
         return this.m_previousState;
      }
      
      public function getState(param1:String, param2:Object = null) : AState
      {
         var _loc3_:AState = null;
         if(!this.m_states[param1])
         {
            throw new Error("<StateMachine::getState()> State " + param1 + " does not exist.");
         }
         if(this.m_states[param1].instance != undefined)
         {
            _loc3_ = this.m_states[param1].instance;
         }
         else
         {
            _loc3_ = new this.m_states[param1]();
         }
         _loc3_.applyParams(param2);
         return _loc3_;
      }
      
      public function getStateClass(param1:String) : Class
      {
         if(!this.m_states[param1])
         {
            throw new Error("<StateMachine::getState()> State " + param1 + " does not exist.");
         }
         return this.m_states[param1];
      }
      
      public function changeGlobalState(param1:AState) : void
      {
         if(param1 == this.m_globalState)
         {
            return;
         }
         if(this.m_globalState)
         {
            this.m_previousGlobalState = this.m_globalState;
            this.m_globalState.exit();
         }
         this.m_globalState = param1;
         this.m_globalState.setAgent(this.m_agent);
         this.m_globalState.initialize();
         this.m_globalState.enter();
      }
      
      public function isInState(param1:Class) : Boolean
      {
         return this.m_currentState is param1;
      }
      
      public function traceConditions() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in this.m_conditions)
         {
         }
      }
      
      public function getCondition(param1:String, param2:Object = null) : ACondition
      {
         if(!this.m_conditions[param1])
         {
            throw new Error("<StateMachine::getCondition()> Condition " + param1 + " does not exist.");
         }
         var _loc3_:ACondition = new this.m_conditions[param1]();
         _loc3_.applyParams(param2);
         return _loc3_;
      }
      
      public function get conditions() : Dictionary
      {
         return this.m_conditions;
      }
      
      public function get previousStateID() : String
      {
         return this.m_previousStateID;
      }
      
      public function traceActions() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in this.m_actions)
         {
         }
      }
      
      public function get actions() : Dictionary
      {
         return this.m_actions;
      }
   }
}

