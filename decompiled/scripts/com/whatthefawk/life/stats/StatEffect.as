package com.whatthefawk.life.stats
{
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class StatEffect extends EventDispatcher
   {
      
      protected var _lifeTime:int;
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_isComplete:Boolean;
      
      protected var _maxStack:int;
      
      protected var _name:String;
      
      private var m_timePassed:int;
      
      public var statSystem:Stats;
      
      protected var _senderID:String;
      
      protected var _tags:Array;
      
      protected var _id:String;
      
      private var m_tickRate:int;
      
      public function StatEffect(param1:StatEffectParams)
      {
         super();
         this._senderID = param1.senderID;
         this._id = param1.id;
         this._name = param1.name;
         this._tags = param1.tags;
         this._maxStack = param1.maxStack;
         this._lifeTime = param1.lifeTime;
         this.m_isComplete = false;
         this.m_tickRate = param1.tickRate;
         this.m_tickRegulator = new TickRegulator(this.m_tickRate);
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTick,false,0,true);
         addEventListener(StatEffectEvent.START,this.onStart,false,0,true);
         addEventListener(StatEffectEvent.COMPLETE,this.onComplete,false,0,true);
      }
      
      public function get isComplete() : Boolean
      {
         return this.m_isComplete;
      }
      
      public function get maxStack() : int
      {
         return this._maxStack;
      }
      
      public function update(param1:int) : void
      {
         if(this.m_isComplete)
         {
            return;
         }
         if(!this.statSystem)
         {
            this.m_isComplete = true;
            throw new Error("No statSystem found in StatEffect " + this.id);
         }
         if(this.m_timePassed == 0)
         {
            dispatchEvent(new StatEffectEvent(StatEffectEvent.START));
         }
         this.m_timePassed += param1;
         if(this.m_timePassed > this._lifeTime)
         {
            this.m_isComplete = true;
            dispatchEvent(new StatEffectEvent(StatEffectEvent.COMPLETE));
            return;
         }
         this.m_tickRegulator.update(param1);
      }
      
      public function onStart(param1:StatEffectEvent) : void
      {
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get senderID() : String
      {
         return this._senderID;
      }
      
      public function get tags() : Array
      {
         return this._tags;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function onTick(param1:Event) : void
      {
      }
      
      public function dispose() : void
      {
         this._tags = null;
         this.m_tickRegulator = null;
      }
      
      public function get lifeTime() : int
      {
         return this._lifeTime;
      }
      
      public function onComplete(param1:StatEffectEvent) : void
      {
      }
   }
}

