package com.getoffmyroof.rewards
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.math.Vector2D;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class RewardSystem extends EventDispatcher
   {
      
      protected var _points:int = 0;
      
      protected var _comboDelay:int = 1000;
      
      protected var _killTypes:Dictionary;
      
      protected var _numCombos:int = 0;
      
      protected var _highCombo:int = 0;
      
      protected var _audioManager:AudioManager;
      
      protected var _timeOfLastKill:int = 0;
      
      protected var _kills:int = 0;
      
      protected var _isLocked:Boolean;
      
      protected var _currentCombo:int = 0;
      
      protected var _timePassed:int = 0;
      
      public function RewardSystem()
      {
         super();
         this._audioManager = GameComponents.instance.getAudioManager();
         this._isLocked = true;
         this._killTypes = new Dictionary();
      }
      
      public function debug() : void
      {
         var _loc1_:* = undefined;
         for(_loc1_ in this.killTypes)
         {
         }
      }
      
      public function get timeOfLastKill() : int
      {
         return this._timeOfLastKill;
      }
      
      public function update(param1:int) : *
      {
         this._timePassed += param1;
      }
      
      public function reset() : *
      {
         this._kills = 0;
         this._killTypes = new Dictionary();
         this._points = 0;
         this._numCombos = 0;
         this._currentCombo = 0;
         this._highCombo = 0;
         this._timePassed = 0;
         this._timeOfLastKill = 0;
      }
      
      public function get numCombos() : int
      {
         return this._numCombos;
      }
      
      public function get highCombo() : int
      {
         return this._highCombo;
      }
      
      public function get isLocked() : Boolean
      {
         return this._isLocked;
      }
      
      public function get kills() : int
      {
         return this._kills;
      }
      
      public function get comboDelay() : int
      {
         return this._comboDelay;
      }
      
      public function pigeonKilled(param1:int, param2:String, param3:Vector2D) : *
      {
         ++this._kills;
         if(this._killTypes[param2] == null)
         {
            this._killTypes[param2] = 1;
         }
         else
         {
            ++this._killTypes[param2];
         }
         if(this._timePassed - this._timeOfLastKill < this._comboDelay)
         {
            ++this._currentCombo;
            if(this._currentCombo > this._highCombo)
            {
               this._highCombo = this._currentCombo;
            }
         }
         else
         {
            if(this._currentCombo > 1)
            {
               ++this._numCombos;
            }
            this._currentCombo = 1;
         }
         var _loc4_:int = param1 * this._currentCombo;
         this._points += _loc4_;
         this._audioManager.play("PointDing");
         dispatchEvent(new RewardSystemEvent(RewardSystemEvent.POINTS,{
            "position":param3,
            "points":_loc4_
         }));
         this._timeOfLastKill = this._timePassed;
      }
      
      public function get points() : int
      {
         return this._points;
      }
      
      public function get currentCombo() : int
      {
         return this._currentCombo;
      }
      
      public function lock() : void
      {
         this._isLocked = true;
      }
      
      public function unlock() : void
      {
         this._isLocked = false;
      }
      
      public function get timePassed() : int
      {
         return this._timePassed;
      }
      
      public function get killTypes() : Dictionary
      {
         return this._killTypes;
      }
   }
}

