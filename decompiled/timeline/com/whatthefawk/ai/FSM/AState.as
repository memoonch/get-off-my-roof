package com.whatthefawk.ai.FSM
{
   import com.whatthefawk.entity.IMessageReceiver;
   import com.whatthefawk.entity.Telegram;
   import com.whatthefawk.utils.ADynamicObject;
   
   public class AState extends ADynamicObject implements IMessageReceiver
   {
      
      private var m_enterActions:Array;
      
      private var m_actions:Array;
      
      private var m_transitions:Array;
      
      private var m_exitActions:Array;
      
      private var m_agent:*;
      
      public function AState()
      {
         super();
         this.m_actions = [];
         this.m_transitions = [];
         this.m_enterActions = [];
         this.m_exitActions = [];
      }
      
      public function setAgent(param1:*) : void
      {
         this.m_agent = param1;
      }
      
      public function get agent() : *
      {
         return this.m_agent;
      }
      
      public function handleMessage(param1:Telegram) : Boolean
      {
         return false;
      }
      
      public function get enterActions() : Array
      {
         return this.m_enterActions;
      }
      
      public function addEnterAction(param1:IAction) : void
      {
         this.m_enterActions.push(param1);
      }
      
      public function hasTransition(param1:Transition) : Boolean
      {
         var _loc2_:int = int(this.m_transitions.length);
         while(--_loc2_ > -1)
         {
            if(this.m_transitions[_loc2_] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function initialize() : void
      {
      }
      
      public function enter() : void
      {
         var _loc1_:IAction = null;
         for each(_loc1_ in this.m_enterActions)
         {
            _loc1_.execute(this.m_agent);
         }
      }
      
      public function removeAction(param1:IAction) : void
      {
         var _loc2_:int = int(this.m_actions.length);
         while(--_loc2_ > -1)
         {
            if(this.m_actions[_loc2_] == param1)
            {
               this.m_actions.splice(_loc2_,1);
               break;
            }
         }
      }
      
      public function addTransition(param1:Transition) : void
      {
         this.m_transitions.push(param1);
      }
      
      public function exit() : void
      {
         var _loc1_:IAction = null;
         for each(_loc1_ in this.m_exitActions)
         {
            _loc1_.execute(this.m_agent);
         }
      }
      
      public function dispose() : void
      {
         this.m_agent = null;
         this.m_actions = null;
         this.m_transitions = null;
         this.m_enterActions = null;
         this.m_exitActions = null;
      }
      
      public function hasAction(param1:IAction) : Boolean
      {
         var _loc2_:int = int(this.m_actions.length);
         while(--_loc2_ > -1)
         {
            if(this.m_actions[_loc2_] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function addExitAction(param1:IAction) : void
      {
         this.m_exitActions.push(param1);
      }
      
      public function addAction(param1:IAction) : void
      {
         this.m_actions.push(param1);
      }
      
      public function removeTransition(param1:Transition) : void
      {
         var _loc2_:int = int(this.m_transitions.length);
         while(--_loc2_ > -1)
         {
            if(this.m_transitions[_loc2_] == param1)
            {
               this.m_transitions.splice(_loc2_,1);
               break;
            }
         }
      }
      
      public function get actions() : Array
      {
         return this.m_actions;
      }
      
      public function get transitions() : Array
      {
         return this.m_transitions;
      }
      
      public function get exitActions() : Array
      {
         return this.m_exitActions;
      }
   }
}

