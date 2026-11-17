package org.flintparticles.common.counters
{
   import org.flintparticles.common.emitters.Emitter;
   
   public class Blast implements Counter
   {
      
      private var _done:Boolean = false;
      
      private var _startCount:uint;
      
      public function Blast(param1:uint = 0)
      {
         super();
         this._startCount = param1;
      }
      
      public function updateEmitter(param1:Emitter, param2:Number) : uint
      {
         return 0;
      }
      
      public function startEmitter(param1:Emitter) : uint
      {
         param1.dispatchCounterComplete();
         return this._startCount;
      }
      
      public function resume() : void
      {
      }
      
      public function stop() : void
      {
      }
      
      public function get startCount() : Number
      {
         return this._startCount;
      }
      
      public function get complete() : Boolean
      {
         return this._done;
      }
      
      public function set startCount(param1:Number) : void
      {
         this._startCount = param1;
      }
   }
}

