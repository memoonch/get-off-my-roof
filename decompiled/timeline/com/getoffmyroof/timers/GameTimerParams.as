package com.getoffmyroof.timers
{
   import com.whatthefawk.utils.Params;
   
   public class GameTimerParams extends Params
   {
      
      public var timeCriticalMin:int = 0;
      
      public var timeIncrement:int = GameTimer.INCREMENT_UP;
      
      public var time:int = -1;
      
      public var timeStartsAt:int = 0;
      
      public var timeEndsAt:int = -1;
      
      public var tickRate:int = 1000;
      
      public var timeCriticalMax:int = 0;
      
      public function GameTimerParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

