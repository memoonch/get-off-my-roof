package com.urbansquall.metronome
{
   import flash.events.Event;
   
   public class TickerEvent extends Event
   {
      
      public static const TICK:String = "tick";
      
      private var m_interval:int;
      
      public function TickerEvent(param1:int)
      {
         super(TICK,false,false);
         this.m_interval = param1;
      }
      
      public function get interval() : int
      {
         return this.m_interval;
      }
   }
}

