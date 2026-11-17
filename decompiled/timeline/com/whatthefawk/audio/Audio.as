package com.whatthefawk.audio
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.getTimer;
   
   public class Audio extends EventDispatcher
   {
      
      public static const COMPLETE:String = "complete";
      
      protected var _ID:String;
      
      protected var _sound:Sound;
      
      protected var _maxChannels:int;
      
      protected var _isPaused:Boolean;
      
      protected var _type:String;
      
      protected var _isPlaying:Boolean;
      
      protected var _lastPlayed:int;
      
      protected var _channels:Array;
      
      protected var _minDelay:int;
      
      protected var _soundTransform:SoundTransform;
      
      public function Audio(param1:AudioParams)
      {
         super();
         this._ID = param1.audioID;
         this._type = param1.type;
         this._sound = param1.sound;
         this._soundTransform = new SoundTransform();
         this._channels = [];
         this._maxChannels = param1.maxChannels;
         this._minDelay = param1.minDelay;
         this._lastPlayed = 0;
         this._isPaused = false;
         this._isPlaying = false;
      }
      
      public function stop(param1:String = null) : void
      {
         var _loc2_:AudioChannel = null;
         for each(_loc2_ in this._channels)
         {
            if(!(Boolean(param1) && _loc2_.ID != param1))
            {
               _loc2_.stop();
            }
         }
      }
      
      public function unpause() : void
      {
         var _loc1_:AudioChannel = null;
         if(!this._isPaused)
         {
            return;
         }
         this._isPaused = false;
         for each(_loc1_ in this._channels)
         {
            _loc1_.unpause();
         }
      }
      
      public function get ID() : String
      {
         return this._ID;
      }
      
      public function get isPlaying() : Boolean
      {
         return this._isPlaying;
      }
      
      public function canPlay() : Boolean
      {
         if(this._channels.length >= this._maxChannels)
         {
            return false;
         }
         var _loc1_:int = getTimer();
         if(_loc1_ - this._lastPlayed < this._minDelay)
         {
            return false;
         }
         this._lastPlayed = _loc1_;
         return true;
      }
      
      private function onAudioChannelComplete(param1:Event) : void
      {
         var _loc2_:AudioChannel = null;
         for each(_loc2_ in this._channels)
         {
            if(_loc2_.isComplete)
            {
               this._channels.splice(this._channels.indexOf(_loc2_),1);
            }
         }
         if(this.numChannels == 0)
         {
            this._isPlaying = false;
            dispatchEvent(new Event(Audio.COMPLETE));
         }
      }
      
      public function volumeTo(param1:Number, param2:Number = 0) : void
      {
         var _loc3_:AudioChannel = null;
         for each(_loc3_ in this._channels)
         {
            _loc3_.volumeTo(param1 * this._soundTransform.volume,param2);
         }
      }
      
      public function get numChannels() : int
      {
         return this._channels.length;
      }
      
      public function modifySoundTransform(param1:Number, param2:Number) : void
      {
         this._soundTransform.volume = param1;
         this._soundTransform.pan = param2;
         this.volumeTo(param1);
         this.panTo(param2);
      }
      
      public function fadeOut(param1:Number = 0) : void
      {
         var _loc2_:AudioChannel = null;
         for each(_loc2_ in this._channels)
         {
            _loc2_.fadeOut(param1);
         }
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function play(param1:int = 0, param2:Number = 1, param3:Number = 0, param4:String = null) : void
      {
         if(!this.canPlay())
         {
            return;
         }
         this._isPlaying = true;
         var _loc5_:SoundTransform = new SoundTransform(param2 * this._soundTransform.volume,param3 + this._soundTransform.pan);
         var _loc6_:SoundChannel = this._sound.play(0,0,_loc5_);
         var _loc7_:AudioChannel = new AudioChannel(new AudioChannelParams({
            "channelID":param4,
            "sound":this._sound,
            "soundChannel":_loc6_,
            "loops":param1
         }));
         _loc7_.addEventListener(AudioChannel.COMPLETE,this.onAudioChannelComplete,false,0,true);
         this._channels.push(_loc7_);
      }
      
      public function pause() : void
      {
         var _loc1_:AudioChannel = null;
         if(this._isPaused)
         {
            return;
         }
         this._isPaused = true;
         for each(_loc1_ in this._channels)
         {
            _loc1_.pause();
         }
      }
      
      public function panTo(param1:Number, param2:Number = 0) : void
      {
         var _loc3_:AudioChannel = null;
         for each(_loc3_ in this._channels)
         {
            _loc3_.panTo(param1 + this._soundTransform.pan,param2);
         }
      }
   }
}

