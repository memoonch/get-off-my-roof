package com.whatthefawk.audio
{
   import com.greensock.TweenMax;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   
   public class AudioChannel extends EventDispatcher
   {
      
      public static const COMPLETE:String = "complete";
      
      protected var _pausePosition:int;
      
      protected var _sound:Sound;
      
      protected var _soundChannel:SoundChannel;
      
      protected var _isPaused:Boolean;
      
      protected var _loops:int;
      
      protected var _isComplete:Boolean;
      
      protected var _ID:String;
      
      public function AudioChannel(param1:AudioChannelParams)
      {
         super();
         this._ID = param1.channelID;
         this._sound = param1.sound;
         this._soundChannel = param1.soundChannel;
         this._loops = param1.loops;
         this._isPaused = false;
         this._isComplete = false;
         this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete,false,0,true);
      }
      
      public function stop() : void
      {
         this._isComplete = true;
         TweenMax.killTweensOf(this._soundChannel);
         this._soundChannel.stop();
         this._soundChannel.removeEventListener(Event.SOUND_COMPLETE,this.onSoundComplete);
         this._soundChannel = null;
         this._sound = null;
         dispatchEvent(new Event(AudioChannel.COMPLETE));
      }
      
      public function get isComplete() : Boolean
      {
         return this._isComplete;
      }
      
      private function onSoundComplete(param1:Event) : void
      {
         --this._loops;
         if(this._loops <= 0)
         {
            this.stop();
         }
         else
         {
            this._soundChannel = this._sound.play(0,0,this._soundChannel.soundTransform);
            this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete,false,0,true);
         }
      }
      
      public function mute() : void
      {
      }
      
      public function get ID() : String
      {
         return this._ID;
      }
      
      private function onFadeOutComplete() : void
      {
         this.stop();
      }
      
      public function fadeOut(param1:Number = 0) : void
      {
         TweenMax.to(this._soundChannel,param1,{
            "volume":0,
            "onComplete":this.onFadeOutComplete
         });
      }
      
      public function volumeTo(param1:Number, param2:Number = 0) : void
      {
         TweenMax.to(this._soundChannel,param2,{"volume":param1});
      }
      
      public function pause() : void
      {
         if(this._isPaused)
         {
            return;
         }
         this._isPaused = true;
         this._pausePosition = this._soundChannel.position;
         this._soundChannel.stop();
      }
      
      public function panTo(param1:Number, param2:Number = 0) : void
      {
      }
      
      public function unmute() : void
      {
      }
      
      public function unpause() : void
      {
         if(!this._isPaused)
         {
            return;
         }
         this._isPaused = false;
         this._soundChannel = this._sound.play(this._pausePosition,0,this._soundChannel.soundTransform);
         this._soundChannel.addEventListener(Event.SOUND_COMPLETE,this.onSoundComplete,false,0,true);
      }
   }
}

