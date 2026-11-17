package com.getoffmyroof.timers
{
   import com.whatthefawk.utils.TickRegulator;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class GameTimer extends EventDispatcher
   {
      
      public static const INCREMENT_UP:int = 1;
      
      public static const INCREMENT_DOWN:int = -1;
      
      public static const INCREMENT_ZERO:int = 0;
      
      private var m_timeEndsAt:int;
      
      private var m_timeIncrement:int;
      
      private var m_tickRegulator:TickRegulator;
      
      private var m_isComplete:Boolean;
      
      private var m_timeCriticalMin:int;
      
      private var m_time:int;
      
      private var m_timeStartsAt:int;
      
      private var m_timeCriticalMax:int;
      
      private var m_timePassed:int;
      
      private var m_tickRate:int;
      
      public function GameTimer(param1:GameTimerParams)
      {
         super();
         this.m_time = param1.time == -1 ? param1.timeStartsAt : param1.time;
         this.m_timePassed = 0;
         this.m_timeEndsAt = param1.timeEndsAt;
         this.m_timeStartsAt = param1.timeStartsAt;
         this.m_timeIncrement = param1.timeIncrement;
         this.m_timeCriticalMin = param1.timeCriticalMin;
         this.m_timeCriticalMax = param1.timeCriticalMax;
         this.m_tickRate = param1.tickRate;
         this.m_tickRegulator = new TickRegulator(this.m_tickRate);
         this.m_tickRegulator.addEventListener(TickRegulator.TICK,this.onTickRegulatorTick,false,0,true);
         this.m_isComplete = false;
      }
      
      public function onTickRegulatorTick(param1:Event) : void
      {
         dispatchEvent(new GameTimerEvent(GameTimerEvent.TICK));
         this.m_time += this.m_timeIncrement;
         if(this.m_time == this.m_timeEndsAt && this.m_timeEndsAt != -1)
         {
            this.m_isComplete = true;
            dispatchEvent(new GameTimerEvent(GameTimerEvent.COMPLETE));
         }
      }
      
      public function get isComplete() : Boolean
      {
         return this.m_isComplete;
      }
      
      public function update(param1:int) : void
      {
         this.m_timePassed += param1;
         this.m_tickRegulator.update(param1);
      }
      
      public function get time() : int
      {
         return this.m_time;
      }
      
      public function reset() : void
      {
         this.m_time = this.m_timeStartsAt;
         this.m_timePassed = 0;
         this.m_isComplete = false;
      }
      
      public function get isTimeCritical() : Boolean
      {
         return this.m_time >= this.m_timeCriticalMin && this.m_time <= this.m_timeCriticalMax;
      }
      
      public function dispose() : void
      {
         this.m_tickRegulator = null;
      }
   }
}

